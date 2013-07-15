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

      get '/punches.json' do
        start_time = Time.at(params[:date].to_i).beginning_of_hour
        end_time = Time.at(params[:date].to_i).end_of_hour
        @punches = Punch.where(created_at: start_time..end_time)
        @punches.to_json root: false
      end

      get '/punches/:id/?' do |id|
        @punch = Punch.find(id)
        haml :punch
      end

      get '/search' do
        return {}.to_json unless params[:fragment]
        @punches = Punch.tagged_with(params[:fragment])
        @punches += Punch.includes(:project).where("projects.name LIKE ? OR description LIKE ? OR comments LIKE ?", "%#{params[:fragment]}%", "%#{params[:fragment]}%", "%#{params[:fragment]}%")
        @punches.to_json(root: false)
      end
    end
  end
end
