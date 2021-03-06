require "vim/secretary/version"

require 'pathname'
require 'treetop'
require 'active_record'
require 'active_support/all'

module Vim
  module Secretary
    def self.timesheet=(file)
      @@timesheet = file
    end

    def self.timesheet
      @@timesheet ||= File.expand_path('~/.secretary')
    end

    def self.timesheet_config
      @@timesheet_config ||= begin
        config = Vim::Secretary::Config.from_timesheet(timesheet)
        config.config
        config
      end
    end

    def self.default_db_config
      {
        database: File.expand_path('~/.secretary.db'),
        adapter: 'sqlite3',
        pool: 5,
      }
    end

    def self.db_config
      (timesheet_config[:database] || default_db_config)
    end

    def self.migrate_db!
      ActiveRecord::Migration.verbose = true
      puts migration_dir = File.expand_path('../../../db/migrate', __FILE__)
      ActiveRecord::Migrator.migrate(migration_dir, nil)
    end

    def self.database_prepared?
      begin
        ActiveRecord::Base.connection.table_exists?('punches')
      rescue
        false
      end
    end

    def self.initialize!
      if timesheet && File.exist?(timesheet)
        ActiveRecord::Base.establish_connection db_config
        migrate_db! unless database_prepared?
        true
      else
        warn "You're using ENRAR. STAHP!"
        Enrar.initialize!
      end
    end
  end
end

require 'vim/secretary/config'
require 'vim/secretary/parser'
require 'vim/secretary/project'
require 'vim/secretary/punch'
require 'vim/secretary/timesheet'

require 'vim/secretary/tag'
require 'vim/secretary/tagging'

require 'vim/secretary/task'
