class Visit < ActiveRecord::Base

  belongs_to :card
  belongs_to :user

  validates :ip_address, :presence => true
  validates :count, :presence => true
  validates_uniqueness_of :user_id, :scope => :card_id, :allow_nil => true
  validates_uniqueness_of :ip_address, :scope => :card_id

end
