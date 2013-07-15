require 'vim/secretary'
require 'rake'
require 'rake/tasklib'

module Vim
  module Secretary

    # Create the Vim::Secretary Rake tasks programmatically.
    # This code was shamelessly stolen and modified from the Rake library.
    class Task < Rake::TaskLib

      # Name of test task. (default is :enrar)
      attr_accessor :name

      # The path to your database.yml file. (default is config/database.yml)
      attr_accessor :database_config
   
      # Do you want me to be noisy?
      attr_accessor :verbose

      # Create the Enrar tasks
      def initialize(name=:secretary)
        @name = name
        @database_config = 'config/database.yml'
        @verbose = verbose
        yield self if block_given?
        define
      end

      # Create the tasks defined by this task lib.
      def define
        desc "Create & migrate the DB for your named TIMESHEET"
        task "#{@name}:prepare", [:timesheet] => ["#{@name}:env"] do |t, args|
          Enrar::Migrator.new.migrate!
        end

        desc "Print the URL for the provided TIMESHEET"
        task "#{@name}:url", [:timesheet] => ["#{@name}:env"] do |t, args|
          require 'socket'
          ip = Socket::getaddrinfo(Socket.gethostname,"echo",Socket::AF_INET)[0][3]
          puts "http://#{ip}:#{@config[:port] || 8912}/"
        end

        task "#{@name}:env", [:timesheet] do |t, args|
          @timesheet = File.expand_path('~/.secretary') unless args[:timesheet]
          @config = Vim::Secretary::Config.from_timesheet(@timesheet)
        end

        self
      end
    end
  end
end
