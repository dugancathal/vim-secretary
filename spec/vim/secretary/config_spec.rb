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

  describe 'default settings' do
    it 'has one for location' do
      @config['location'].must_equal '.'
    end
  end
end
