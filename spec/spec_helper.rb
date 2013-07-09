require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/mock'
require 'minitest/pride'
require 'minitest/benchmark'

require 'database_cleaner'

require 'vim/secretary'

PROJECT_ROOT = Pathname.new File.expand_path('../../', __FILE__)
ENV['ENRAR_ENV'] ||= 'test'

Vim::Secretary.initialize!

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

def stub_config
  text = "---\nconfig_option: 1\n"
  Vim::Secretary::Config.new(text)
end

class MiniTest::Spec
  after(:each) do
    DatabaseCleaner.clean
  end
end
