class Card < ActiveRecord::Base

  before_create :generate_code

  belongs_to :order
  has_many :visits
  has_many :contact_requests
  has_many :notification_requests

  validates_uniqueness_of :code

  attr_accessible :message

  def giver
    return order.user
  end

  def to_s
    return "http://conne.cc/#{self.code}"
  end

  def record_visit(ip_address, user)
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
      Visit.create! :user => user, :ip_address => ip_address, :card => self
    end

    self.visited = true
    self.save!
  end

  protected

  def generate_code
    chars = 'abcdefghjkmnpqrstuvwxyz23456789'
    self.code = ''
    5.times { |i| self.code << chars[rand(chars.length)] }

    # check for duplicates
    if Card.find_by_code(self.code)
      self.generate_code
    end
  end

end
