class CreateTaggables < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name
    end

    create_table :taggings do |t|
      t.references :tag
      t.references :punch
    end

    add_index :taggings, :tag_id
    add_index :taggings, :punch_id
  end

  def self.down
    drop_table :taggings
    drop_table :tags
  end
end
