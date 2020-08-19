class CompanyDetailsController < ApplicationController
  before_action :require_current_user

  def create
    # @curriculum = Curriculum.new
    token = info_current_user
    user = User.find(token[0]['user_id'])
    id = Company.find(user.profile_id)
    address = CompanyAddress.create(params_address)
    personal = CompanyPersonal.create(params_personal)
    @company = Company.find(id)
    @company.candidate_personal = personal
    @company.candidate_address = address

    if @curriculum.save
      render json: { header: @curriculum, pastJobs: @curriculum.jobs, address: @curriculum.candidate_address, personal: @curriculum.candidate_personal }
    else
      render json: { message: @curriculum.errors.full_messages }
    end
  end
end
