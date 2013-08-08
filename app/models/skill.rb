# == Schema Information
#
# Table name: skills
#
#  id         :integer          not null, primary key
#  teacher_id :integer
#  subject_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Skill < ActiveRecord::Base
	belongs_to :teacher
	belongs_to :subject
end
