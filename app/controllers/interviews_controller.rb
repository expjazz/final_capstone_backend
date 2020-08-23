class InterviewsController < ApplicationController
  def create
    if params[:company_id]
      @company = Company.find(params[:company_id])
      @user = User.find(info_current_user[0]['user_id'])
      @candidate = Candidate.find(@user.profile_id)
      @interview = Interview.create(candidate: @candidate, company: @company, job_offer_id: params[:job_offer_id], status: 'waiting for confirmation from the company', time: params[:time])
    end

    render json: @interview.as_json(include: %i[company candidate job_offer]) if @interview
  end

  def update
    @interview = Interview.find_by(candidate_id: params[:candidate_id], company_id: params[:company_id], job_offer_id: params[:job_offer_id])

    @interview.time = params[:time] if params[:time]
    @interview.status = params[:status] if params[:status]
    render json: @interview.as_json(include: %i[company candidate job_offer]) if @interview.save
  end
end
