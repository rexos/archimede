class Student < ActiveRecord::Base
	has_one :address
	has_secure_password
  	attr_accessible :email, :last_name, :name, :password_digest, :phone, :password, :password_confirmation

  validates :name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true, :uniqueness => true
  validates :password, :presence => true, :length => { :minimum => 6 }, :on => :create
  validates :password_confirmation, :presence => true, :on => :create
end
