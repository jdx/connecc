class Card < ActiveRecord::Base

  before_create :generate_code
  before_destroy :destroy_visits

  belongs_to :order
  has_many :visits

  def to_s
    return "http://conne.cc/#{self.code}"
  end

  protected

  def generate_code
    chars = 'abcdefghjkmnpqrstuvwxyz23456789'
    self.code = ''
    5.times { |i| self.code << chars[rand(chars.length)] }
  end

  def destroy_visits
    self.visits.each do |v|
      v.destroy
    end
  end

end
