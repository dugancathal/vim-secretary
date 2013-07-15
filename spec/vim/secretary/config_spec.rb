require 'spec_helper'
require 'tempfile'

describe Vim::Secretary::Config do
  before(:all) do
    @config = Vim::Secretary::Config.new("config_option: 1")
  end
  it 'is straight-forward YAML' do
    @config.config.must_be_kind_of Hash
    @config.config['config_option'].must_equal 1
  end

  it 'delegates #[]' do
    @config['config_option'].must_equal 1
  end

  it 'has indifferent access' do
    @config[:config_option].must_equal 1
    @config['config_option'].must_equal 1
  end

  describe '.from_timesheet' do
    before(:all) do
      file = PROJECT_ROOT.join('spec', 'fixtures', 'secretary-sample-config').to_s
      @config = Vim::Secretary::Config.from_timesheet(file)
    end

    it 'generates a config from a timesheet file' do
      @config[:name].must_equal "TJ's Timesheet"
      @config[:port].must_equal 8915
      @config[:database].must_be_kind_of Hash
      @config[:database][:database].must_equal 'secretary'
    end
  end
end
