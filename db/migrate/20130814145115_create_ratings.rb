class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :value, :default => 2
      t.references :student
      t.references :teacher

      t.timestamps
    end
    add_index :ratings, :student_id
    add_index :ratings, :teacher_id
  end
end
