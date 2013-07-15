module Vim
  module Secretary
    class Punch < ::ActiveRecord::Base
      belongs_to :project
      belongs_to :timesheet

      has_many :taggings
      has_many :tags, :through => :taggings

      delegate :name, to: :project, prefix: true

      def self.tagged_with(name)
        Tag.where(name: name).map {|tag| tag.punches}.flatten
      end

      def self.tag_counts
        Tag.select("tags.*, count(taggings.tag_id) as count").
          joins(:taggings).group("taggings.tag_id")
      end

      def tag_names
        tags.map(&:name)
      end

      def tag_names=(names)
        self.tags = names.map do |n|
          Tag.where(name: n.strip).first_or_create!
        end
      end
      
      def tag_list
        tags.map(&:name).join(", ")
      end
      
      def tag_list=(names)
        self.tags = names.split(",").map do |n|
          Tag.where(name: n.strip).first_or_create!
        end
      end

      def as_json(options = {})
        super(options.merge(methods: [:tag_names, :project_name]))
      end
    end 
  end
end
