module Vim
  module Secretary
    class Timesheet < ActiveRecord::Base
      def configuration
        parsed_content.config
      end

      def parsed_content
        parser.parse unless parser.config
        parser
      end

      def parser
        @parser ||= Parser.new(location)
      end
    end
  end
end
