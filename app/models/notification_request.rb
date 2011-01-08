class NotificationRequest < ActiveRecord::Base
  belongs_to :card
  belongs_to :user

  validates :email, :presence => true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_uniqueness_of :email, :scope => :card_id
  validates :card, :presence => true
  validates :ip_address, :presence => true

  attr_accessible :email

end
