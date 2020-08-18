class RegistrationsController < Devise::RegistrationsController
  respond_to :json
  include ActionController::Cookies

  def create
    build_resource(sign_up_params)
    resource.profile = Candidate.create(name: 'test')
    if resource.valid?
      resource.save
      token = encode_token({ user_id: resource.id, token: 'token' })
      cookies[:token] = { value: token, httponly: true }
      render_resource(resource)
    else
      render json: { message: resource.errors.full_messages }
    end
  end
end
