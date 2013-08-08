class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :password_digest
      t.string :token
      t.boolean :admin, :default => :false

      t.timestamps
    end
  end
end
