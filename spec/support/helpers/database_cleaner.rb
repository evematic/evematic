require "database_cleaner/active_record"

module DatabaseCleaner
  module ActiveRecord
    class Base < DatabaseCleaner::Strategy
      def self.migration_table_name
        ::ActiveRecord::Base.connection.schema_migration.table_name
      end
    end
  end
end
