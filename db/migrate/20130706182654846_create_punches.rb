class CreatePunches < ActiveRecord::Migration
  def change
    create_table :punches do |t|
      t.references :project
      t.references :timesheet
      t.integer :time_worked
      t.string :description
      t.text :comments

      t.timestamps
    end

    add_index :punches, :project_id
    add_index :punches, :timesheet_id
  end
end
