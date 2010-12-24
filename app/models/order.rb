class Order < ActiveRecord::Base
  belongs_to :user
  validates :user, :presence => true

  def to_s
    "#{ self.id }: #{ self.user.email }"
  end

end
