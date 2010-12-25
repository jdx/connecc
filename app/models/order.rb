class Order < ActiveRecord::Base
  before_create :set_type, :start_order

  belongs_to :user
  validates :user, :presence => true
  validates :address, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :zip, :presence => true, :format => /^\d{5}(-\d{4})?$/

  def to_s
    "Order #{ self.id }"
  end

  def set_type
    self.type = "Order" unless self.type
  end

  def generate_order
    self.status = 'awaiting-shipment'
  end

  protected

  def start_order
    self.placed_at = DateTime.now
    self.status = 'awaiting-generation'
  end

end
