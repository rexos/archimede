class Address < ActiveRecord::Base
  belongs_to :student, :class_name => 'Student', :foreign_key => 'student_id'
  belongs_to :teacher, :class_name => 'Teacher', :foreign_key => 'teacher_id'
  belongs_to :bill, :class_name => 'Bill', :foreign_key => 'bill_id'
  attr_accessible :cap, :city, :country, :number, :province, :street, :latitude, :longitude, :student_id, :teacher_id, :bill_id
end
