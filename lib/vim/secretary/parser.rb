require 'date'

module Vim
  module Secretary
    class Parser
      attr_reader :lines, :punches, :config
      COMMENT_OR_NIL_LINE_REGEX = /^\s*($|#.*$)/

      PUNCH_LINE = /^
                    (\S+?)\s+
                    \[(.*?)?(?::(.*?))?\]
                    \s+\-\s+
                    (.*)
                    $/x

      def initialize(file)
        @file = file
        @lines = File.read(file).split("\n")
        @punches = []
      end

      def parse
        generate_config!
        remove_comments!
        group_into_punches
      end

      private

      def generate_config!
        config_text = ""
        @lines.each do |line|
          !line.match(/#\s+\-{3}/) ? config_text << "#{line.gsub(/# /, '')}\n" : break
        end
        @config = Vim::Secretary::Config.new(config_text)
      end

      def remove_comments!
        @lines.reject! {|line| line.match(COMMENT_OR_NIL_LINE_REGEX) }
      end

      def group_into_punches
        return @punches unless @punches.empty?
        @lines.each do |line|
          if project = extract_punch_from_line(line)
            @punches << project
          else
            @punches.last[:notes].concat line.squeeze
          end
        end
      end

      def extract_punch_from_line(line)
        if match = line.match(PUNCH_LINE)
          {
            date: DateTime.parse(match[1]),
            name: match[2].blank? ? file_parent_directory : match[2],
            tags: match[3].to_s.split(':'),
            notes: match[4].strip,
          }
        end
      end

      def file_parent_directory
        dir = File.dirname(@file)
        dir.split('/').last
      end
    end
  end
end
