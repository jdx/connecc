class Order < ActiveRecord::Base
  before_validation :get_missing_data

  belongs_to :user
  has_many :cards
  belongs_to :buyer_billing_address, :class_name => 'Address'
  belongs_to :buyer_shipping_address, :class_name => 'Address'

  validates :type, :presence => true
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true
  validates :cards_amount, :presence => true

  def cancel
    self.canceled = true
    self.save!
  end

  def ship
    self.shipped = true
    self.save!
  end

  def to_s
    "Order #{ id }"
  end

  def name
    "#{ self.first_name } #{ self.last_name }"
  end

  def email_address_with_name
    "#{ self.name } <#{ self.email }>"
  end

  def generate_cards
    self.cards.each { |c| c.destroy }
    self.cards_amount.times do
      self.cards << Card.new
    end
    self.save!
  end

  protected

  def get_missing_data
    self.first_name = self.user.first_name unless self.first_name
    self.last_name = self.user.last_name unless self.last_name
    self.email = self.user.email unless self.email
    self.buyer_billing_address = self.buyer_shipping_address unless self.buyer_billing_address
  end

end
