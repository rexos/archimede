# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  street     :string(255)
#  number     :integer
#  cap        :integer
#  city       :string(255)
#  province   :string(255)
#  country    :string(255)
#  latitude   :float
#  longitude  :float
#  student_id :integer
#  teacher_id :integer
#  bill_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Address < ActiveRecord::Base
  acts_as_gmappable

  belongs_to :student, :class_name => 'Student', :foreign_key => 'student_id'
  belongs_to :teacher, :class_name => 'Teacher', :foreign_key => 'teacher_id'
  belongs_to :bill, :class_name => 'Bill', :foreign_key => 'bill_id'
  attr_accessible :cap, :city, :country, :number, :province, :street, :latitude, :longitude, :student_id, :teacher_id, :bill_id, :gmaps

  validates_presence_of :cap, :city, :country, :province, :street

  def gmaps4rails_address
    "#{self.street} #{self.number} #{self.city} #{self.cap} #{self.province} #{self.country}"
  end


end
