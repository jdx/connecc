class User < ActiveRecord::Base

  has_many :orders
  has_many :visits
  has_many :contact_requests
  has_one :trial_order

  validates :name, :presence => true

  devise :database_authenticatable,
         :lockable,
         :recoverable,
         :trackable,
         :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email,
                  :password,
                  :remember_me,
                  :city,
                  :state,
                  :zip_code,
                  :phone_number,
                  :address_1,
                  :address_2,
                  :name,

  def to_s
    self.name
  end

  def email_address_with_name
    "#{ self.name } <#{ self.email }>"
  end

end
