class PrivateBetaController < ApplicationController
  def splash
    if request.post?
      @email = PrivateBeta.new params[:private_beta]
      if @email.save
        @email = nil
      end
    else
      @email = PrivateBeta.new
    end
  end
end
