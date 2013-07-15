module Vim
  module Secretary
    class Config
      def initialize(config_text = '')
        @text = config_text
      end

      def config
        @config ||= HashWithIndifferentAccess.new(parse!(@text))
      end

      def [](key)
        key = key.to_sym
        config[key]
      end

      def self.from_timesheet(filename)
        File.read(filename).match(/(.*)# ---/m) do |match|
          self.new(match[1].gsub(/^# /, ''))
        end
      end

      private

      def parse!(text)
        YAML::load(text, symbolize_keys: true)
      end
    end
  end
end
