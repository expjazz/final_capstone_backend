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
      if @user.profile_type == 'Candidate'
        render json: { user: { name: @user.profile.name, gerenalInfo: @user }, curriculum: { header: @user.curriculum, pastJobs: @user.curriculum.jobs, address: @user.curriculum.candidate_address, personal: @user.curriculum.candidate_personal } }
      elsif @user.profile_type == 'Company'
        render json: { user: { name: @user.profile.name, generalInfo: @user }, companyInfo: { header: @user.profile.header, jobOffers: @user.job_offers, address: @user.profile.company_address, personal: @user.profile.company_personal } }

      end
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
