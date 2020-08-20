class JobOffersController < ApplicationController
  before_action :require_current_user
  def create
    @user = User.find(info_current_user[0]['user_id'])
    @job = JobOffer.new(params_job)
    @job.user = @user 
    if @job.save 
      render json: @job 
    else  
      render json: { message: @job.errors.full_messages}
    end
  end

  def index
  end

  private

  def params_job 
    params.require(:job_offer).permit(:requirement, :salary, :position)
  end
end

