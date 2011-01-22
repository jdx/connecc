class TrialOrder < Order
  after_create :charge

  validates :user, :presence => true
  validates :address1, :presence => true
  validates :city, :presence => true
  validates :postal_code, :presence => true
  validates :region, :presence => true

  protected

  def set_type
    type = 'TrialOrder'
  end

end

