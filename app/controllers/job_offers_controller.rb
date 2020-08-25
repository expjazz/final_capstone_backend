class JobOffersController < ApplicationController
  before_action :require_current_user, only: :create
  def create
    @user = User.find(info_current_user[0]['user_id'])
    @company = Company.find(@user.profile_id)
    @job = JobOffer.new(params_job)
    @job.user = @user
    if @job.save
      render json: @job.as_json(include: { candidates: { include: { user: { include: { curriculum: { include: %i[candidate_address candidate_personal] } }, only: %i[email id] } }, only: %i[name id] } })
    else
      render json: { message: @job.errors.full_messages }
                end
  end

  def index
    render json: JobOffer.all.as_json(include: [{ user: { include: { profile: { only: %i[name id image_url] } }, only: %i[email id image_url] } }, { candidates: { include: { user: { include: :curriculum } }, only: [:name] } }, { approved: { include: { user: { include: :curriculum } }, only: [:name] } }])
  end

  private

  def params_job
    params.require(:job_offer).permit(:requirement, :salary, :position)
  end
end
