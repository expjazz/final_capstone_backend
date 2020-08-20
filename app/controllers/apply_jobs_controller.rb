class ApplyJobsController < ApplicationController
  before_action :require_current_user

  include ActionController::Cookies

  def create
    @user = User.find(info_current_user[0]['user_id'])
    @candidate = Candidate.find(@user.profile_id)
    @job = Job.find(params[:job_id])
    @candidate_application = CandidateJobApplication.create(candidate: @candidate, job: @job, status: 'loading')
    if @candidate
      render json: @candidate_application
    else  
      render json: {message: 'needs to be a candidate'}
    end
  end

  def index
  end
end