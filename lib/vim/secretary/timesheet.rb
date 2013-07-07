module Vim
  module Secretary
    class Timesheet
      def initialize(config = Config.new)
        @config = config
      end

      def filename
        @config['location']
      end

      def clock_in(project_name, start_time = Time.now, end_time = nil)
        project = Project.where(name: project_name).first_or_create
        project.punches.create(start: start_time, end: end_time)
      end

      def entries
        Punch.all
      end
    end
  end
end
