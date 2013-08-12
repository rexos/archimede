class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :teacher
      t.string :body
      t.timestamps
    end
    add_index :notifications, :teacher_id
  end
end
