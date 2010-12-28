class TrialOrder < Order
  before_create :set_card_number

  def to_s
    return "Order #{ self.id } (trial)"
  end

  def set_card_number
    self.cards_amount = 10
  end
end
