class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
    	t.belongs_to :teacher
      	t.belongs_to :subject
      	t.timestamps
    end
  end
end
