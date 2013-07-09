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
        config[key] || default_configs[key]
      end

      private

      def parse!(text)
        YAML::load(text, symbolize_keys: true)
      end

      def default_configs
        HashWithIndifferentAccess.new({
          location: '.',
          database: {
            adapter: 'sqlite3',
            database: '.secretary.sqlite3',
            pool: 1,
          },
          web: {
            port: 8912,
          },
        })
      end
    end
  end
end
