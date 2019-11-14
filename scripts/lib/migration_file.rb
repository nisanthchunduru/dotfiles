require 'pathname'
require 'fileutils'

class MigrationFile
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def name
    File.basename(path)
  end

  def version
    Pathname.new(path).basename.to_s.split("_").first
  end

  def delete
    FileUtils.rm(path)
  end
end
