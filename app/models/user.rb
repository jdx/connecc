class User < ActiveRecord::Base

  has_many :orders
  has_many :visits
  has_many :contact_requests
  has_many :cards, :through => :orders
  has_one :trial_order

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :gender, :presence => true
  validates :time_zone, :presence => true

  devise :database_authenticatable,
         :lockable,
         :recoverable,
         :trackable,
         :validatable,
         :rememberable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email,
                  :first_name,
                  :last_name,
                  :gender,
                  :time_zone,
                  :password

  def to_s
    self.name
  end

  def email_address_with_name
    "#{ self.name } <#{ self.email }>"
  end

  def name
    return "#{ self.first_name } #{ self.last_name }"
  end

  def personal_pronoun
    self.gender == 'm' ? 'he' : 'she'
  end

  def demonstrative_pronoun
    self.gender == 'm' ? 'him' : 'her'
  end

end
