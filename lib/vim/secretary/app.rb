require 'sinatra'
require 'haml'
require 'redcarpet'
require 'vim/secretary'

module Vim
  module Secretary
    class App < Sinatra::Base
      set :public_dir, File.expand_path('../public', __FILE__)
      set :views, File.expand_path('../views', __FILE__)
      set :haml, format: :html5, layout: :application

      class << self
        attr_accessor :timesheet, :markdown
      end

      self.timesheet = Vim::Secretary::Timesheet
        .where(location: File.expand_path('~/.secretary')).first_or_create
      self.markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)

      set :port, timesheet.configuration['port']

      helpers do
        def timesheet_name
          self.class.timesheet.configuration['name']
        end

        def markdown
          self.class.markdown
        end
      end

      after do
        ActiveRecord::Base.clear_active_connections!
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

      get '/punches-for-calendar.json?' do
        punches = Punch.where(created_at: DateTime.parse(params[:start])..DateTime.parse(params[:end]))
        calendar_spots = punches
          .each_with_object({}) {|punch, h| h[punch.created_at.to_i.to_s] = 1}
        calendar_spots.to_json
      end

      get '/punches/:id/?' do |id|
        @punch = Punch.find(id)
        haml :punch
      end
    end
  end
end
