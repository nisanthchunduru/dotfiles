require_relative "lib/migration"

migration_version_or_name = ARGV[0]
Migration.new(migration_version_or_name).delete
