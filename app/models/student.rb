# == Schema Information
#
# Table name: students
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  last_name       :string(255)
#  email           :string(255)
#  phone           :string(255)
#  password_digest :string(255)
#  token           :string(255)
#  admin           :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Student < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :last_name, :name, :password_digest, :phone, :password, :password_confirmation, :token, :admin

  #relationships
  has_one :address, :dependent => :destroy
  has_many :ratings

  before_create :generate_token
  after_create :update_id

  #regular expressions
  EMAIL_REGEX = /\b[A-Z0-9._+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i
  PSW_REGEX = /^(?=.*[a-zA-Z])(?=.*[0-9]{2,}).{6,}$/i

  #validations
  validates :name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true, :uniqueness => true, :format => { :with => EMAIL_REGEX }
  validates :password, :presence => true, :format => { :with => PSW_REGEX }, :on => :create
  validates :password_confirmation, :presence => true, :on => :create

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end

  def update_id
    if self.id.odd?
      old = self.id
      new = old + 1
      sql = "update students set id=#{new} where id=#{old}"
      ActiveRecord::Base.connection.execute(sql)
    end
  end

end
