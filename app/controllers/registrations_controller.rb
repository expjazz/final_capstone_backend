class RegistrationsController < Devise::RegistrationsController
  respond_to :json
  include ActionController::Cookies

  def encode_token(payload)
    JWT.encode(payload, ENV['DEVISE_SECRET_KEY'])
  end

  def create
    build_resource(sign_up_params)
    resource.profile = Candidate.create(name: 'test')
    if resource.valid?
      resource.save
      token = encode_token({ user_id: resource.id, token: 'token' })
      cookies[:token] = { value: token, httponly: true }
    end
    render_resource(resource)
  end
end
