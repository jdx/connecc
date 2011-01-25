class Admin::DelayedJobsController < Admin::AdminController

  def index
    @delayed_jobs = DelayedJob.order(:id)
  end

  def show
    @delayed_job = DelayedJob.find(params[:id])
  end

end
