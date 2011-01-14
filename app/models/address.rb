class Address < ActiveRecord::Base

  validates :address1, :presence => true
  validates :city, :presence => true
  validates :postal_code, :presence => true
  validates :region, :presence => true

  def to_s
    return "#{address1} #{address2} #{city}, #{region} #{postal_code}"
  end

end
