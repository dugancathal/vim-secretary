class CreatePunches < ActiveRecord::Migration
  def change
    create_table :punches do |t|
      t.references :project
      t.datetime :start
      t.datetime :end
    end
  end
end
