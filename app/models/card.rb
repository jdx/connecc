class Card < ActiveRecord::Base

  before_create :generate_code
  before_destroy :destroy_data

  belongs_to :order
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

  def destroy_data
    self.contact_requests.each { |v| v.destroy }
    self.notification_requests.each { |v| v.destroy }
  end

end
