class Teacher < ActiveRecord::Base
  attr_accessible :active, :address, :availability_days, :bill_bool, :cost, :deadline, :email, :info, :last_name, :name, :phone, :range, :rating, :rating_bool, :skype, :skype_bool, :time_bank_bool
end
