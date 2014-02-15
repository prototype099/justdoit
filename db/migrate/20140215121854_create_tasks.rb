class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :event_id
      t.integer :user_id
      t.text :content
      t.string :state

      t.timestamps
    end
  end
end
