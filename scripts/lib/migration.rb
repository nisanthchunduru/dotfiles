require "active_support/inflector"

require_relative "./migration_file"

class Migration
  attr_reader :version

  def initialize(version_or_name)
    if version?(version_or_name)
      version = version_or_name
      @migration_file = all_migration_files.find { |migration_file| migration_file.name.start_with?(version) }
    else
      name = version_or_name
      snake_cased_name = name.underscore
      @migration_file = all_migration_files.find { |migration_file| migration_file.name.end_with?("#{snake_cased_name}.rb") }
    end

    @version = @migration_file.version
  end

  def run
    system("bundle exec rake db:migrate:up VERSION=#{version}")
  end

  def revert
    system("bundle exec rake db:migrate:down VERSION=#{version}")
  end

  def delete
    @migration_file.delete
  end

  private

  def version?(version_or_name)
    /^\d{14}$/ =~ version_or_name
  end

  def all_migration_files
    @all_migration_files ||= all_migration_filepaths.map { |migration_filepath| MigrationFile.new(migration_filepath) }
  end

  def all_migration_filepaths
    @all_migration_filepaths ||= all_migration_filenames.map { |migration_filename| File.join(rails_root, "db", "migrate", migration_filename) }
  end

  def all_migration_filenames
    @all_migration_filenames ||= Dir.entries(File.join(rails_root, "db", "migrate")) - [".", ".."]
  end

  def rails_root
    @rails_root ||= `pwd`.chomp
  end
end
