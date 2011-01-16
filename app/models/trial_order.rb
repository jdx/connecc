class TrialOrder < Order
  after_create :charge

  protected

  def set_type
    type = 'TrialOrder'
  end

end

