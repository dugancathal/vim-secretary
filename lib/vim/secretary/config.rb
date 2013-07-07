module Vim
  module Secretary
    class Config
      attr_reader :location
      def initialize(location = '~/.secretary.conf')
        @location = location
      end

      def config
        @config ||= HashWithIndifferentAccess.new(parse!(@location))
      end

      def [](key)
        key = key.to_sym
        config[key] || default_configs[key]
      end

      private
      
      def parse!(file)
        YAML::load(File.read(file), symbolize_keys: true)
      end

      def default_configs
        {
          location: '~/.secretary'
        }
      end
    end
  end
end
