class ApplyJobsController < ApplicationController
  before_action :require_current_user

  include ActionController::Cookies

  def create
    @user = User.find(info_current_user[0]['user_id'])
    @candidate = Candidate.find(@user.profile_id)
    @job = JobOffer.find(params[:job_offer_id])
    @candidate_application = CandidateJobApplication.create(candidate: @candidate, job_offer: @job, status: 'loading')
    if @candidate
      render json: @candidate_application
    else
      render json: { message: 'needs to be a candidate' }
    end
  end

  def accept_application
    @user = User.find(info_current_user[0]['user_id'])
    @candidate = Candidate.find(params[:candidate_id])
    @job = JobOffer.find(params[:job_offer_id])
    @candidate_application = ApplicationAccepted.create(candidate: @candidate, job_offer: @job)
    if @candidate
      render json: @candidate_application
    else
      render json: { message: 'needs to be a candidate' }
    end
  end

  def index; end
end
