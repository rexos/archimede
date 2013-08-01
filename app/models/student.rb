class Student < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :last_name, :name, :password_digest, :phone, :password, :password_confirmation, :token

  #relationships
  has_one :address

  before_create :generate_token
  after_create :update_id

  #validations
  validates :name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true, :uniqueness => true
  validates :password, :presence => true, :length => { :minimum => 6 }, :on => :create
  validates :password_confirmation, :presence => true, :on => :create

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end

  def update_id
    old = self.id
    new = old + 1
    sql = "update students set id=#{new} where id=#{old}"
    ActiveRecord::Base.connection.execute(sql)
  end

end
