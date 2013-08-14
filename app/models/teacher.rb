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
#  skype_bool        :boolean          default(FALSE)
#  cost              :string(255)
#  range             :integer
#  availability_days :string(255)
#  info              :string(255)
#  rating_bool       :boolean          default(FALSE)
#  rating            :integer
#  time_bank_bool    :boolean          default(FALSE)
#  bill_bool         :boolean          default(FALSE)
#  deadline          :date
#  active            :boolean          default(FALSE)
#  password_digest   :string(255)
#  token             :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Teacher < ActiveRecord::Base
  has_secure_password
  attr_accessible :active, :availability_days, :bill_bool, :cost, :deadline, :email, :info, :last_name, :name, :phone, :range, :rating, :rating_bool, :skype, :skype_bool, :time_bank_bool, :password, :password_confirmation, :token

  #relationships
  has_one :address, :dependent => :destroy
  has_one :notification, :dependent => :destroy
  has_many :ratings, :dependent => :destroy
  has_many :bills, :dependent => :destroy
  has_many :skills, :dependent => :destroy
  has_many :subjects, through: :skills

  before_create :generate_token
  after_create :update_id

  #regular expressions
  EMAIL_REGEX = /\b[A-Z0-9._+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i
  PSW_REGEX = /^(?=.*[a-zA-Z])(?=.*[0-9]{2,}).{6,}$/i

  #validations
  validates :name, :presence => true
  validates :last_name, :presence => true
  validates_inclusion_of :time_bank_bool, :in => [ true, false ]
  validates_inclusion_of :bill_bool, :in => [ true, false ]
  validates_inclusion_of :rating_bool, :in => [ true, false ]
  validates :email, :presence => true, :uniqueness => true, :format => { :with => EMAIL_REGEX  }
  validates :password, :presence => true, :format => { :with => PSW_REGEX }, :on => :create
  validates :password_confirmation, :presence => true, :on => :create

  #private methods
  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end

  def update_id
    if self.id.even?
      old = self.id
      new = old + 1
      sql = "update teachers set id=#{new} where id=#{old}"
      ActiveRecord::Base.connection.execute(sql)
    end
  end

end
