require_relative "lib/migration"

migration_name = ARGV[0]
puts Migration.new(migration_name).version
