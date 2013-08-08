# == Schema Information
#
# Table name: bills
#
#  id            :integer          not null, primary key
#  business_name :string(255)
#  last_name     :string(255)
#  name          :string(255)
#  cf            :string(255)
#  iva           :string(255)
#  teacher_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Bill < ActiveRecord::Base
  attr_accessible :business_name, :cf, :iva, :last_name, :name, :teacher_id
  belongs_to :teacher
  has_one :address, :dependent => :destroy

  validates_presence_of :cf, :iva, :last_name, :name, :business_name

end
