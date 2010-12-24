class Order < ActiveRecord::Base
  belongs_to :user
  validates :user, :presence => true

  def to_s
    "Order #{ self.id }"
  end

end
