class SessionsController < Devise::SessionsController
  respond_to :json
  include ActionController::Cookies
  def create
    @user = User.find_by(email: params[:user][:email])

    if @user.valid_password?(params[:user][:password])
      token = encode_token({ user_id: @user.id, token: 'token' })
      cookies[:token] = { value: token, httponly: true, same_site: :none }
      render 'sessions/logged?.json.jbuilder'

    else
      render json: { message: 'Wrong email or password' }
    end
  end

  def logged?
    if cookies[:token]
      token = JWT.decode(cookies[:token], ENV['DEVISE_SECRET_KEY'])
      @user = User.find(token[0]['user_id']) || nil
      render json: { message: 'no user logged in' } unless @user
      render 'sessions/logged?.json.jbuilder'

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
