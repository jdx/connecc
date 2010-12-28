class ContactRequest < ActiveRecord::Base
  belongs_to :card
  belongs_to :user

  validates :card, :presence => true
  validates :contact_info, :presence => true
  validates :ip_address, :presence => true

  attr_accessible :contact_info, :message
end
