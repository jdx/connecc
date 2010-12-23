class TrialController < ApplicationController
  before_filter :previous_trials_check

  def new
    @trial = Trial.new
  end

  def create
    @trial = Trial.new params[:trial]
    @trial.user = current_user
    @trial.placed_at = DateTime.now
    if @trial.save
      redirect_to dashboard_path, :notice => 'Expect your trial pack soon!'
    else
      render :new
    end
  end

  protected

  def previous_trials_check
    if current_user.trials.any?
      flash[:notice] = "Only one trial order per customer please"
      redirect_to dashboard_path
    end
  end

end
