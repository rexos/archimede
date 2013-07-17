class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :skype
      t.boolean :skype_bool
      t.string :cost
      t.string :address
      t.integer :range
      t.string :availability_days
      t.string :info
      t.boolean :rating_bool
      t.integer :rating
      t.boolean :time_bank_bool
      t.boolean :bill_bool
      t.date :deadline
      t.boolean :active

      t.timestamps
    end
  end
end
