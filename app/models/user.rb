class User < ActiveRecord::Base

  before_save :default_values
  before_update :clean_contact_info

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
  validates_format_of :twitter, :with => /^@?[a-z0-9_]*$/, :allow_blank => true, :allow_nil => true
  validates_format_of :phone_number, :with => /^(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$/, :allow_blank => true, :allow_nil => true
  validates_format_of :web_site, :with => /^([\w-]+:\/\/)?(www[.])?[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|\/))$/, :allow_blank => true, :allow_nil => true
  validates_format_of :facebook, :with => /^.*facebook\.com\/[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|\/))$/, :allow_blank => true, :allow_nil => true
  validates_format_of :linkedin, :with => /^.*linkedin\.com\/in\/[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|\/))$/, :allow_blank => true, :allow_nil => true

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
                  :password,
                  :twitter,
                  :linkedin,
                  :facebook,
                  :web_site,
                  :show_email,
                  :phone_number

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

  def any_contact_info_public?
    if show_email or !facebook.blank? or !linkedin.blank? or !twitter.blank? or !web_site.blank? or !phone_number.blank?
      return true
    else
      return false
    end
  end

  protected

  def clean_contact_info
    self.web_site = "http://" + self.web_site if self.web_site and not self.web_site =~ /^https?:\/\//
    self.facebook.gsub!(/.*facebook.com/, 'facebook.com') if self.facebook
    self.linkedin.gsub!(/.*linkedin.com/, 'linkedin.com') if self.linkedin
    self.twitter.gsub!(/^@?/, '@') if self.twitter
  end

  def default_values
    self.gender = 'm' unless self.gender
    self.time_zone = 'Pacific Time (US & Canada)' unless self.time_zone
  end

end
