require 'date'

module Vim
  module Secretary
    class Parser
      attr_reader :lines, :projects, :config
      COMMENT_OR_NIL_LINE_REGEX = /^\s*($|#.*$)/

      PROJECT_LINE = /^
                      (\S+?)\s+
                      \[(.*?)(?::(.*?))?\]
                      \s+\-\s+
                      (.*)
                      $/x

      def initialize(file)
        @file = file
        @lines = File.read(file).split("\n")
        @projects = []
      end

      def parse
        generate_config!
        remove_comments!
        group_into_projects
      end

      private

      def generate_config!
        config_text = ""
        @lines.each {|line| !line.match(/#\s+\-{3}/) ? config_text << line : break }
        @config = Vim::Secretary::Config.new(config_text)
      end

      def remove_comments!
        @lines.reject! {|line| line.match(COMMENT_OR_NIL_LINE_REGEX) }
      end

      def group_into_projects
        return @projects unless @projects.empty?
        @lines.each do |line|
          if project = extract_project_from_line(line)
            @projects << project
          else
            @projects[-1][-1].concat line.squeeze
          end
        end
      end

      def extract_project_from_line(line)
        if match = line.match(PROJECT_LINE)
          [DateTime.parse(match[1]), match[2], match[3].split(':'), match[4].strip]
        end
      end
    end
  end
end
