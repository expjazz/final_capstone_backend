class RegistrationsController < Devise::RegistrationsController
  respond_to :json
  include ActionController::Cookies

  def create
    build_resource(sign_up_params)
    resource.profile = Candidate.new(name: params[:candidate][:name]) if params[:candidate]
    resource.profile = Company.new(name: params[:company][:name]) if params[:company]
    resource.profile = Admin.new(name: params[:admin][:name]) if params[:admin]

    if resource.save
      token = encode_token({ user_id: resource.id, token: 'token' })
      cookies[:token] = { value: token, httponly: true }
      render json: { user: { generalInfo: resource, name: resource.profile.name } }
    else
      render json: { message: resource.errors.full_messages }
    end
  end

  private

  def profile_params(param); end
end
