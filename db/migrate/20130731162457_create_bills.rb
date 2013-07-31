class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :business_name
      t.string :last_name
      t.string :name
      t.string :cf
      t.string :iva
      t.integer :teacher_id

      t.timestamps
    end
  end
end
