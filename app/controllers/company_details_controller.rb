class CompanyDetailsController < ApplicationController
  before_action :require_current_user

  def create
    # @curriculum = Curriculum.new
    @user = User.new(user_params)
    @company = Company.new(company_params)
    @user.profile = @company
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

  private

  def user_params
    params.require(:user).permit(:password, :email)
  end

  def company_params
    params.require(:company).permit(:name)
  end

  def params_address
    params[:company].require(:company_address).permit(:country, :cep, :state, :city, :hood, :street, :cel)
  end

  def params_personal
    params[:company].require(:company_personal).permit(:cnpj, :size, :about_us)
  end
end
