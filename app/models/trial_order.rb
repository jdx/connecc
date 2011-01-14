class TrialOrder < Order
  before_validation :set_type, :default_values
  before_save :update_state

  accepts_nested_attributes_for :buyer_shipping_address, :user

  protected

  def set_type
    type = 'TrialOrder'
  end

  def default_values
    self.cards_amount = 10
    self.authorization_amount = 0
  end

  def update_state
    self.state = 'awaiting-shipment'
    self.state = 'shipped' if self.shipped
  end

end

