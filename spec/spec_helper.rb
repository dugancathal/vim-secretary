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
  @file = Tempfile.new(PROJECT_ROOT.join('.secretary.conf').to_s)
  @file.write "---\nconfig_option: 1\n"
  @file.close

  Vim::Secretary::Config.new(@file.path)
end

def destroy_stubbed_config
  @file.unlink
end

class MiniTest::Spec
  after(:each) do
    DatabaseCleaner.clean
  end
end
