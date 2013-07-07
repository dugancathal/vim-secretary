class CreatePunches < ActiveRecord::Migration
  def change
    create_table :punches do |t|
      t.references :project
      t.integer :time_worked
      t.string :notes

      t.timestamps
    end

    add_index :punches, :project_id
  end
end
