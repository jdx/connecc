class GoogleOrder < Order
  before_create :set_type
  before_save :update_state

  protected

  def set_type
    type = 'GoogleOrder'
  end

  def update_state
    self.state = 'new'
    self.state = 'awaiting-charge' if self.user
    self.state = 'awaiting-activation' if self.authorization_amount
    self.state = 'awaiting-shipment' if self.authorization_amount and self.user
    self.state = 'shipped' if self.shipped
  end

end
