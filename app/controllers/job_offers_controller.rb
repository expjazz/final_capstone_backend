class JobOffersController < ApplicationController
  before_action :require_current_user
  def create
    @user = User.find(info_current_user[0]['user_id'])
    @company = Company.find(@user.profile_id)
    @job = JobOffer.new(params_job)
    @job.user = @user
    if @job.save
      render json: { newJob: @job, company: @company }
    else
      render json: { message: @job.errors.full_messages }
                end
  end

  def index
    render json: JobOffer.all.as_json(include: [{ user: { include: { profile: { only: :name } }, only: :email } }, { candidates: { include: { user: { include: :curriculum } }, only: [:name] } }, { approved: { include: { user: { include: :curriculum } }, only: [:name] } }])
  end

  private

  def params_job
    params.require(:job_offer).permit(:requirement, :salary, :position)
  end
end
