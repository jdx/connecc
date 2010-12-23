class Order < ActiveRecord::Base
  belongs_to :user

  def to_s
    "#{ self.id }: #{ self.user.email }"
  end

end
