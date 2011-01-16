require 'google4r/checkout'

class OrdersController < ApplicationController
  before_filter :authenticate_user!

end

