class Order < ActiveRecord::Base
  after_initialize :set_type
  before_save :update_state

  belongs_to :user
  has_many :cards

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  def charge(amount=0)
    self.authorization_amount = amount
    self.charged = true
    self.save!
  end

  def cancel(reason)
    self.cards.each { |c| c.destroy }
    self.canceled = reason
    self.save!
  end

  def ship
    self.shipped = true
    self.save!
  end

  def to_s
    "Order #{ id }"
  end

  def address
    "#{ address1 } #{ address2}, #{ city }, #{ region } #{ postal_code }"
  end

  def add_cards(num)
    self.cards.each { |c| c.destroy }
    num.times do
      self.cards << Card.new
    end
    self.save!
  end

  protected

  def update_state
    self.state = 'new'
    self.state = 'awaiting-shipment' if self.charged
    self.state = 'shipped' if self.shipped
    self.state = 'canceled' if self.canceled
  end

end
