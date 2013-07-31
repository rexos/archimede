# == Schema Information
#
# Table name: teachers
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  last_name         :string(255)
#  email             :string(255)
#  phone             :string(255)
#  skype             :string(255)
#  skype_bool        :boolean
#  cost              :string(255)
#  range             :integer
#  availability_days :string(255)
#  info              :string(255)
#  rating_bool       :boolean
#  rating            :integer
#  time_bank_bool    :boolean
#  bill_bool         :boolean
#  deadline          :date
#  active            :boolean
#  password_digest   :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Teacher < ActiveRecord::Base
  has_secure_password
  attr_accessible :active, :availability_days, :bill_bool, :cost, :deadline, :email, :info, :last_name, :name, :phone, :range, :rating, :rating_bool, :skype, :skype_bool, :time_bank_bool, :password, :password_confirmation

  EMAIL_REGEX = /\b[A-Z0-9._+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i

  validates :name, :presence => true
  validates :last_name, :presence => true
  validates_inclusion_of :time_bank_bool, :in => [ true, false ]
  validates_inclusion_of :bill_bool, :in => [ true, false ]
  validates_inclusion_of :rating_bool, :in => [ true, false ]
  validates :email, :presence => true, :uniqueness => true
  validates :password, :presence => true, :length => { :minimum => 6 }, :on => :create
  validates :password_confirmation, :presence => true, :on => :create

end
