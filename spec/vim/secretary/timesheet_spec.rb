require 'spec_helper'

describe Vim::Secretary::Timesheet do
  before(:all) { @config = stub_config }

  describe '#filename' do
    it 'exists' do
      Vim::Secretary::Timesheet.new(@config).filename.wont_be_nil
    end

    it 'defaults to ~/.secretary' do
      Vim::Secretary::Timesheet.new(@config).filename.must_equal '.secretary.sqlite3'
    end
  end
end
