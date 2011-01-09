class User < ActiveRecord::Base
  before_destroy :orphan_visits, :orphan_contact_requests

  has_many :orders
  has_many :visits
  has_many :contact_requests
  has_one :trial_order

  validates :name, :presence => true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,  and :timeoutable
  devise :database_authenticatable,
         :lockable,
         :recoverable,
         :rememberable,
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

  protected

  def orphan_visits
    self.visits.each do |v|
      v.user_id = nil
      v.save!
    end
  end

  def orphan_contact_requests
    contact_requests.each do |c|
      c.user_id = nil
      c.save!
    end
  end

end
