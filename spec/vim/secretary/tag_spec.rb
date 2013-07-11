require 'spec_helper'

describe Vim::Secretary::Tag do
  before(:all) do
    5.times do |n|
      project = Vim::Secretary::Project.create name: "Project tag#{n}"
      project.tag_names = Array("tag#{n}")
    end
  end
 
  it "is attached to projects" do
    tag = Vim::Secretary::Tag.where(name: 'tag1').first
    tag.projects.size.must_equal 1
  end

  describe "Project.tagged_with" do
    it 'can find all projects with a tag' do
      Vim::Secretary::Project.tagged_with('tag1').size.must_equal 1
    end
  end
end
