# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  teacher_id :integer
#  body       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Notification < ActiveRecord::Base
  attr_accessible :body
  belongs_to :teacher
end
