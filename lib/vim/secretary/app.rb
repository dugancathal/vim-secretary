require 'sinatra'
require 'haml'
require 'vim/secretary'

module Vim
  module Secretary
    class App < Sinatra::Base
      set :public_dir, File.expand_path('../public', __FILE__)
      set :views, File.expand_path('../views', __FILE__)
      set :haml, format: :html5, layout: :application

      class << self
        attr_accessor :timesheet
      end

      helpers do
        def timesheet_name
          self.class.timesheet.configuration['name']
        end
      end

      before do
        unless self.class.timesheet
          self.class.timesheet =
            Vim::Secretary::Timesheet.where(location: File.expand_path('~/.secretary'))
              .first_or_create
        end
      end

      get '/' do
        redirect to('/projects/')
      end

      get '/projects/?' do
        @projects = Project.all
        haml :projects
      end

      get '/projects/:id/?' do |id|
        @project = Project.find(id)
        haml :project
      end

      get '/punches/:id/?' do |id|
        @punch = Punch.find(id)
        haml :punch
      end
    end
  end
end
