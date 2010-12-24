class User < ActiveRecord::Base

  has_many :orders
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :address_1, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :zip_code, :presence => true
  validates :phone_number, :presence => true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,  and :timeoutable
  devise :database_authenticatable,
         :registerable,
         :lockable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email,
                  :password,
                  :password_confirmation,
                  :remember_me

  def to_s
    "#{ self.first_name } #{ self.last_name}"
  end

end
