 class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.integer :number
      t.integer :cap
      t.string :city
      t.string :province
      t.string :country
      t.integer :student_id
      t.integer :teacher_id
      t.integer :bill_id

      t.timestamps
    end
  end
end
