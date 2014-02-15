class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :owner_id
      t.string :title
      t.text :description
      t.string :place
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
