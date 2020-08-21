class InterviewsController < ApplicationController
  def create
    @job = JobOffer.find(params[:job_offer_id])
    if params[:company_id]
      @company = Company.find(params[:company_id])
      @user = User.find(info_current_user[0]['user_id'])
      @candidate = Candidate.find(@user.profile_id)
      @interview = Interview.create(candidate: @candidate, company: @company, job_offer: @job, status: 'waiting for confirmation from the company', time: params[:time])
    end
  end

  def update; end
end
