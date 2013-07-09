require 'spec_helper'

describe Vim::Secretary::Timesheet do
  it 'has a location' do
    timesheet = Vim::Secretary::Timesheet.new location: 'somewhere'
    timesheet.location.must_equal 'somewhere'
  end

  it 'has a configuration' do
    file = PROJECT_ROOT.join('spec', 'fixtures', 'secretary-sample-full').to_s
    timesheet = Vim::Secretary::Timesheet.new location: file
    timesheet.configuration.wont_be_nil
    timesheet.configuration['location'].must_equal '.'
  end
end
