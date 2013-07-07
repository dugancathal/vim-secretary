require 'spec_helper'
require 'tempfile'

describe Vim::Secretary::Config do
  it 'has a config location' do
    Vim::Secretary::Config.new.location.must_equal '~/.secretary.conf'
    Vim::Secretary::Config.new('~/.sec.conf').location.must_equal '~/.sec.conf'
  end

  describe 'file' do
    before(:all) { @config = stub_config }

    after(:all) { destroy_stubbed_config }

    it 'is straight-forward YAML' do
      @config.config.must_be_kind_of Hash
      @config.config['config_option'].must_equal 1
    end

    it 'delegates #[]' do
      @config['config_option'].must_equal 1
    end

    describe 'default settings' do
      it 'has one for location' do
        @config['location'].must_equal '~/.secretary'
      end
    end
  end
end
