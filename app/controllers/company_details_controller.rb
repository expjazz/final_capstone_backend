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
      render json: { user: { generalInfo: @user, name: @user.profile.name }, companyInfo: { header: @company.header, address: @company.company_address, personal: @company.company_personal, image: @user.profile.image_url } }
    else
      render json: { message: @company.errors.full_messages }
    end
  end

  def update
    token = JWT.decode(cookies[:token], ENV['DEVISE_SECRET_KEY'])

    @user = User.find(token[0]['user_id'])
    @user.profile.update(company_params)
    @user.profile.company_address.update(params_address)
    @user.profile.company_personal.update(params_personal)
    render json: { user: { generalInfo: @user, name: @user.profile.name }, companyInfo: { header: @user.profile.header, address: @user.profile.company_address, personal: @user.profile.company_personal, image: @user.profile.image_url } }
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
