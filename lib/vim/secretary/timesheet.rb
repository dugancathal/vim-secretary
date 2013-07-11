module Vim
  module Secretary
    class Timesheet < ActiveRecord::Base
      has_many :punches, dependent: :destroy
      has_many :projects, through: :punches, dependent: :destroy

      def configuration
        parsed_content.config
      end

      def parsed_content
        parser.parse unless parser.config
        parser
      end

      def parser
        @parser ||= begin
          parser = Parser.new(location)
          parser.parse
          parser
        end
      end

      def persist_punches!
        parser.punches.each do |punch_data|
          project = project_from_punch(punch_data)
          punch = punches.where(
            created_at: punch_data[:date],
            project_id: project.id
          ).first_or_create(
            notes: punch_data[:notes],
            timesheet_id: self.id
          )
          append_tags_to_project(project, punch_data[:tags])
          punch.save
        end
      end

      private

      def project_from_punch(punch)
        projects.where(name: punch[:name]).first_or_create
      end

      def append_tags_to_project(project, tags)
        project.tag_names = project.tag_names | tags
      end
    end
  end
end
