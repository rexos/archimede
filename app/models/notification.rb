class Notification < ActiveRecord::Base
  attr_accessible :body
  belongs_to :teacher
end
