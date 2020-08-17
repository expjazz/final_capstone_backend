class SessionsController < Devise::SessionsController
  respond_to :json
  include ActionController::Cookies

  def encode_token(payload)
    JWT.encode(payload, ENV['DEVISE_SECRET_KEY'])
  end

  def create
    super
    if @user
      token = encode_token({ user_id: @user.id, token: 'token' })
      cookies[:token] = { value: token, httponly: true }
    end
  end

  private

  def respond_with(resource, _opts = {})
    render json: resource
    end

  def respond_to_on_destroy
    head :ok
      end
end
