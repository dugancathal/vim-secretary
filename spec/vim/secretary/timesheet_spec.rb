require 'spec_helper'

describe Vim::Secretary::Timesheet do
  before(:all) { @config = stub_config }
  after(:all) { destroy_stubbed_config }

  describe '#filename' do
    it 'exists' do
      Vim::Secretary::Timesheet.new(@config).filename.wont_be_nil
    end

    it 'defaults to ~/.secretary' do
      Vim::Secretary::Timesheet.new(@config).filename.must_equal '~/.secretary'
    end
  end

  describe '#clock_in' do
    it "creates the project if it doesn't exist" do
      timesheet = Vim::Secretary::Timesheet.new(@config)
      timesheet.clock_in 'My First Project'
      timesheet.entries.size.must_equal 1
    end
  end
end
