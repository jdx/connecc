class Order < ActiveRecord::Base
  after_initialize :set_type
  before_save :update_state

  belongs_to :user
  has_many :cards

  validates :user, :presence => true
  validates :address1, :presence => true
  validates :city, :presence => true
  validates :postal_code, :presence => true
  validates :region, :presence => true

  def charge(amount=0)
    self.authorization_amount = amount
    self.charged = true
    self.save!
  end

  def cancel
    self.cards.each { |c| c.destroy }
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

  def add_cards(num)
    self.cards.each { |c| c.destroy }
    num.times do
      self.cards << Card.new
    end
    self.save!
  end

  def update_state
    self.state = 'new'
    self.state = 'awaiting-shipment' if self.charged
    self.state = 'shipped' if self.shipped
    self.state = 'canceled' if self.canceled
  end

end
