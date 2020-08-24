class CompanyDetailsController < ApplicationController
  # before_action :require_current_user

  def create
    # @curriculum = Curriculum.new
    @user = User.new(user_params)
    @company = Company.new(company_params)
    @user.profile = @company
    address = CompanyAddress.create(params_address)
    personal = CompanyPersonal.create(params_personal)
    @company.company_personal = personal
    @company.company_address = address

    if @user.save
      token = encode_token({ user_id: @user.id, token: 'token' })
      cookies[:token] = { value: token, httponly: true }
      render json: { user: { generalInfo: @user, image: @user.profile.image_url, name: @user.profile.name }, companyInfo: { header: @company.header, address: @company.company_address, personal: @company.company_personal } }
    else
      render json: { message: @curriculum.errors.full_messages }
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :email)
  end

  def company_params
    params.require(:company).permit(:name, :header, :image_url)
  end

  def params_address
    params[:company].require(:company_address).permit(:country, :cep, :state, :city, :hood, :street, :cel)
  end

  def params_personal
    params[:company].require(:company_personal).permit(:cnpj, :size, :aboutUs)
  end
end
