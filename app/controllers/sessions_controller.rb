class SessionsController < Devise::SessionsController
  respond_to :json
  include ActionController::Cookies

  def create
    @user = User.find_by(email: params[:user][:email])

    if @user.valid_password?(params[:user][:password])
      token = encode_token({ user_id: @user.id, token: 'token' })
      cookies[:token] = { value: token, httponly: true }
      if @user.profile_type == 'Candidate'
        if @user.curriculum
          render json: { user: { name: @user.profile.name, gerenalInfo: @user }, curriculum: { header: @user.curriculum, pastJobs: @user.curriculum.jobs, address: @user.curriculum.candidate_address, personal: @user.curriculum.candidate_personal } }
        else
          render json: { user: { name: @user.profile.name, gerenalInfo: @user } }

        end
      elsif @user.profile_type == 'Company'
        render json: { user: { name: @user.profile.name, generalInfo: @user }, companyInfo: { header: @user.profile.header, jobOffers: @user.job_offers, address: @user.profile.company_address, personal: @user.profile.company_personal } }
      end
    else
      render json: { message: 'Wrong email or password' }
    end
  end

  def logged?
    if cookies[:token]
      token = JWT.decode(cookies[:token], ENV['DEVISE_SECRET_KEY'])
      @user = User.find(token[0]['user_id'])
      if @user.profile_type == 'Candidate'
        if @user.curriculum
          render json: { user: { name: @user.profile.name, gerenalInfo: @user, jobsApplied: @user.profile.jobs_applied }, curriculum: { header: @user.curriculum, pastJobs: @user.curriculum.jobs, address: @user.curriculum.candidate_address, personal: @user.curriculum.candidate_personal } }
        else
          render json: { user: { generalInfo: @user, name: @user.profile.name, jobsApplied: @user.profile.jobs_applied } }
        end
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
