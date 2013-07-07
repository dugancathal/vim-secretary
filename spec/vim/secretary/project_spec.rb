require 'spec_helper'

describe Vim::Secretary::Project do
  it 'has many punches' do
    project = Vim::Secretary::Project.new
    project.punches.wont_be_nil
  end
end
