class Address < ActiveRecord::Base
	belongs_to :student, :class_name => 'Student', :foreign_key => 'student_id'
	belongs_to :teacher, :class_name => 'Teacher', :foreign_key => 'teacher_id'
  	attr_accessible :cap, :city, :country, :number, :province, :street, :student_id, :teacher_id
end
