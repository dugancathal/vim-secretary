module Vim
  module Secretary
    class Timesheet
      def initialize(config = Config.new)
        @config = config
      end

      def filename
        @config['location']
      end

      def clock_in(project_name, time_worked = 0, notes = nil)
        project = Project.where(name: project_name).first_or_create
        project.punches.create(time_worked: time_worked, notes: notes)
      end

      def entries
        Punch.all
      end
    end
  end
end
