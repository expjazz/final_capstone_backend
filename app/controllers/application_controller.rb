class ApplicationController < ActionController::API
  respond_to :json
  include ActionController::Cookies

  def render_resource(resource)
    if resource.errors.empty?
      render json: resource
    else
      validation_error(resource)
    end
  end

  def encode_token(payload)
    JWT.encode(payload, ENV['DEVISE_SECRET_KEY'])
  end

  def validation_error(resource)
    render json: {
      errors: [
        {
          status: '400',
          title: 'Bad Request',
          detail: resource.errors,
          code: '100'
        }
      ]
    }, status: :bad_request
  end

  def info_current_user
    JWT.decode(cookies[:token], ENV['DEVISE_SECRET_KEY'])
  end

  def require_current_user
    if cookies[:token]
      puts JWT.decode(cookies[:token], ENV['DEVISE_SECRET_KEY'])
    else
      render json: { message: 'needs user' }
    end
  end
end
