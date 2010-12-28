class Order < ActiveRecord::Base
  before_create :start_order
  after_create :send_notifications
  before_destroy :destroy_cards

  belongs_to :user
  has_many :cards
  validates :user, :presence => true
  validates :address, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :zip, :presence => true, :format => /^\d{5}(-\d{4})?$/

  def to_s
    "Order #{ self.id }"
  end

  def generate_cards
    self.generated_at = DateTime.now
    self.status = 'awaiting-shipment'
    self.cards_amount.times do
      self.cards << Card.new
    end
    self.save!
  end

  def ship
    self.shipped_at = DateTime.now
    self.status = 'shipped'
    self.save!
  end

  protected

  def start_order
    self.placed_at = DateTime.now
    self.status = 'awaiting-generation'
  end

  def send_notifications
    OrderNotifier.placed(self).deliver
  end

  def destroy_cards
    self.cards.each do |c|
      c.destroy
    end
  end

end
