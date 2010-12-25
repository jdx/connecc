class Card < ActiveRecord::Base

  before_create :generate_code

  belongs_to :order

  def to_s
    return "#{self.code}"
  end

  def generate_code
    chars = 'abcdefghjkmnpqrstuvwxyz23456789'
    self.code = ''
    5.times { |i| self.code << chars[rand(chars.length)] }
  end

end
