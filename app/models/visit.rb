class Visit < ActiveRecord::Base

  belongs_to :card
  belongs_to :user

  validates :ip_address, :presence => true
  validates :count, :presence => true
  validates_uniqueness_of :user_id, :scope => :card_id, :allow_nil => true
  validates_uniqueness_of :ip_address, :scope => :card_id

  def self.record(card, ip_address, user)
    # This should be pushed out to a worker thread eventually

    # Find a visit by user id if the user is logged in
    visit = Visit.find_by_user_id(user.id) if user
    # Find a visit by ip address if there was none found
    visit = Visit.find_by_ip_address(ip_address) unless visit
    if visit
      # Visit exists, update the count and values if they changed
      visit.user = user
      visit.ip_address = ip_address
      visit.increment!(:count)
    else
      Visit.create! :user => user, :ip_address => ip_address, :card => card
    end
  end

end
