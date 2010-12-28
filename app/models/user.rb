class User < ActiveRecord::Base
  before_destroy :destroy_orders, :destroy_visits

  has_many :orders
  has_many :visits
  has_one :trial_order

  validates :first_name, :presence => true
  validates :last_name, :presence => true

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
                  :remember_me,
                  :city,
                  :state,
                  :zip_code,
                  :phone_number,
                  :address_1,
                  :address_2,
                  :last_name,
                  :first_name

  def to_s
    self.full_name
  end

  def full_name
    "#{ self.first_name} #{ self.last_name}"
  end

  def email_address_with_name
    "#{ self.full_name } <#{ self.email }>"
  end

  protected

  def destroy_orders
    self.orders.each do |o|
      o.destroy
    end
  end

  def destroy_orders
    self.visits.each do |v|
      v.user_id = nil
      v.save!
    end
  end

end
