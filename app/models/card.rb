class Card < ActiveRecord::Base

  before_create :generate_code

  belongs_to :order
  has_many :visits
  has_many :contact_requests
  has_many :notification_requests

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
  end

end
