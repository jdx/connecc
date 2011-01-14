class GoogleOrder < Order
  after_initialize :set_type
  before_save :update_state

  after_create :start_activation

  protected

  def set_type
    self.type = 'GoogleOrder'
  end

  def update_state
    self.state = 'new'
    self.state = 'awaiting-charge' if self.user
    self.state = 'awaiting-activation' if self.authorization_amount
    self.state = 'awaiting-shipment' if self.authorization_amount and self.user
    self.state = 'shipped' if self.shipped
    self.state = 'canceled' if self.canceled
  end

  def start_activation
    unless self.user
      # first try to find a user
      self.user = User.find_by_email(self.email)
      self.user = User.find_by_email(self.email) unless self.user
      unless user
        # No user found, send notification and await activation
        self.activation_string = ActiveSupport::SecureRandom.hex(16)
        OrderNotifier.activation(self).deliver
      end
    end
  end

end
