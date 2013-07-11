require 'spec_helper'
require 'rack/test'

require 'vim/secretary/app'

describe Vim::Secretary::App do
  include Rack::Test::Methods
  
  def app
    Vim::Secretary::App
  end

  before(:all) do
    @timesheet_file = PROJECT_ROOT.join('spec/fixtures/secretary-sample-full').to_s
    @timesheet = Vim::Secretary::Timesheet.new location: @timesheet_file
    @timesheet.persist_punches!
    app.timesheet = @timesheet
  end

  describe 'app' do
    it 'has a timesheet' do
      app.timesheet.must_equal @timesheet
    end
  end

  describe '/' do
    it 'redirects to /projects' do
      get '/'
      last_response.status.must_equal 302
    end
  end

  describe '/projects/' do
    it 'gets a list of projects' do
      get '/projects/' 
      last_response.body.must_match /My Project/i
    end

    it 'shows the timesheet name' do
      get '/projects/'
      last_response.body.must_match /TJ\'s Timesheet/i
    end
  end

  describe '/projects/:id' do
    it "shows the project's name" do
      project = Vim::Secretary::Project.first
      get "/projects/#{project.id}"
      last_response.body.must_match project.name
    end
  end

  describe '/punches/:id' do
    it "shows the punch's timestamp" do
      punch = Vim::Secretary::Punch.first
      get "/punches/#{punch.id}"
      last_response.body.must_match punch.created_at.to_s(:long)
    end
  end
end
