module Vim
  module Secretary
    class Timesheet
      def initialize(config = Config.new)
        @config = config
      end

      def filename
        @config['database']['database']
      end
    end
  end
end
