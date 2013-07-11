require 'spec_helper'

describe Vim::Secretary::Timesheet do
  before(:all) do
    @file = PROJECT_ROOT.join('spec', 'fixtures', 'secretary-sample-full').to_s
    @timesheet = Vim::Secretary::Timesheet.new location: @file
    @timesheet.save
  end

  it 'has a location' do
    timesheet = Vim::Secretary::Timesheet.new location: 'somewhere'
    timesheet.location.must_equal 'somewhere'
  end

  it 'has a configuration' do
    @timesheet.configuration.wont_be_nil
    @timesheet.configuration['location'].must_equal '.'
  end

  describe '#persist_punches' do
    it "persists it's projects" do
      @timesheet.projects.count.must_equal 0
      @timesheet.persist_punches!
      @timesheet.projects.count.must_equal 4
    end

    it "doesn't duplicate projects" do
      @timesheet.persist_punches!
      @timesheet.persist_punches!
      Vim::Secretary::Project.count.must_equal 3
    end

    it "stores the tags from the projects" do
      @timesheet.persist_punches!
      Vim::Secretary::Tag.count.must_equal 5
      Vim::Secretary::Project.tagged_with('tag1').size.must_equal 2
    end
  end
end
