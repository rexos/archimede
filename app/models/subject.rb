class Subject < ActiveRecord::Base
  attr_accessible :name

  has_many :skills
  has_many :teachers, through: :skills
end
