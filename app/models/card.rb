class Card < ActiveRecord::Base

  before_create :generate_code

  belongs_to :order
  belongs_to :user
  has_many :visits
  has_many :contact_requests
  has_many :notification_requests

  validates :order, :presence => true
  validates :code, :presence => true
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

end
