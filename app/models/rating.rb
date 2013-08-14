# == Schema Information
#
# Table name: ratings
#
#  id         :integer          not null, primary key
#  value      :integer          default(2)
#  student_id :integer
#  teacher_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Rating < ActiveRecord::Base
  belongs_to :student
  belongs_to :teacher
  attr_accessible :value
end
