class SessionsController < Devise::SessionsController
  respond_to :json
  include ActionController::Cookies

  def create
    super
    if @user
      token = encode_token({ user_id: @user.id, token: 'token' })
      cookies[:token] = { value: token, httponly: true }
    end
  end

  def logged?
    if cookies[:token]
      token = JWT.decode(cookies[:token], ENV['DEVISE_SECRET_KEY'])
      @user = User.find(token[0]['user_id'])
      render json: @user
    else 
      render json: { message: 'no user logged in' }
    end
  end

  def delete
    cookies.delete :token
    render json: { message: 'log out success' }
  end

  private

  def respond_with(resource, _opts = {})
    render json: resource
    end

  def respond_to_on_destroy
    head :ok
      end
end
