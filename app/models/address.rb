class Address < ActiveRecord::Base

  validates :address1, :presence => true
  validates :city, :presence => true
  validates :country_code, :presence => true
  validates :postal_code, :presence => true
  validates :region, :presence => true

  def to_s
    return "#{address1} #{address2} #{city} #{region} #{postal_code}"
  end

  def self.create_from_google(google)
    result = Address.new

    result.address1 = google.address1
    result.address2 = google.address2
    result.city = google.city
    result.company_name = google.company_name
    result.contact_name = google.contact_name
    result.country_code = google.country_code
    result.email = google.email
    result.fax = google.fax
    result.phone = google.phone
    result.postal_code = google.postal_code
    result.region = google.region

    return result.save!
  end

end
