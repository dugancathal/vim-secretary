require 'date'
require 'vim/secretary/secretary_parser'

module Vim
  module Secretary
    class Parser
      attr_reader :lines, :punches, :config
      def initialize(file)
        @file = file
        @data = File.read(file)
        @punches = []
        @parser = SecretaryParser.new
      end

      def parse
        generate_config!
        extract_punches
      end

      private

      def generate_config!
        @config = Config.new tree.configs.map(&:as_yaml).join("\n")
      end

      def extract_punches
        @punches = tree.punches.elements.map(&:to_h)
        @punches.each do |punch|
          punch[:date] = DateTime.parse punch[:date]
          punch[:name] = file_parent_directory if punch[:name].blank?
        end
        @punches
      end

      def tree
        @tree ||= begin
          if tree = @parser.parse(@data)
            tree
          else
            raise "Unable to parse your file. #{@parser.failure_reason}"
          end
        end
      end

      def file_parent_directory
        dir = File.dirname(@file)
        dir.split('/').last
      end
    end
  end
end
