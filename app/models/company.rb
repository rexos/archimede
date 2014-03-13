class Company < ActiveRecord::Base
    attr_accessible :email, :name, :owner, :phone
    
    EMAIL_REGEX = /\b[A-Z0-9._+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i
    
    validates_presence_of :name, :owner, :phone
    validates :email, :presence => true, :uniqueness => true, :format => { :with => EMAIL_REGEX }
end
