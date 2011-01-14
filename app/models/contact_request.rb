class ContactRequest < ActiveRecord::Base
  belongs_to :card
  belongs_to :user

  validates :card, :presence => true
  validates :email, :presence => true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :ip_address, :presence => true

  attr_accessible :email, :message, :send_me_a_copy
end
