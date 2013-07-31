class Bill < ActiveRecord::Base
  attr_accessible :business_name, :cf, :iva, :last_name, :name, :teacher_id
  belongs_to :teacher
  has_one :address, :dependent => :destroy
end
