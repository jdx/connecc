class TrialOrder < Order

  def to_s
    return "Order #{ self.id } (trial)"
  end
end
