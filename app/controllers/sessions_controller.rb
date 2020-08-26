class SessionsController < Devise::SessionsController
  respond_to :json
  include ActionController::Cookies

  def create
    @user = User.find_by(email: params[:user][:email])

    if @user.valid_password?(params[:user][:password])
      token = encode_token({ user_id: @user.id, token: 'token' })
      cookies[:token] = { value: token, httponly: true, same_site: :none }
      if @user.profile_type == 'Candidate'
        if @user.curriculum
          render json: { user: { name: @user.profile.name, generalInfo: @user, image: @user.profile.image_url }, curriculum: { header: @user.curriculum, pastJobs: @user.curriculum.jobs, address: @user.curriculum.candidate_address, personal: @user.curriculum.candidate_personal }, interviews: @user.profile.interviews.as_json(include: %i[company candidate job_offer]) }
        else
          render json: { user: { name: @user.profile.name, generalInfo: @user, image: @user.profile.image_url } }

        end
      elsif @user.profile_type == 'Company'
        render json: { user: { name: @user.profile.name, image: @user.profile.image_url, generalInfo: @user }, companyInfo: { header: @user.profile.header, jobOffers: @user.job_offers.as_json(include: [{ candidates: { include: { user: { include: { curriculum: { include: %i[candidate_address candidate_personal] } }, only: %i[email id image_url] } }, only: %i[name id image_url] } }, :approved]), address: @user.profile.company_address, personal: @user.profile.company_personal }, interviews: @user.profile.interviews.as_json(include: %i[company candidate job_offer]) }
      end
    else
      render json: { message: 'Wrong email or password' }
    end
  end

  def logged?
    if cookies[:token]
      token = JWT.decode(cookies[:token], ENV['DEVISE_SECRET_KEY'])
      @user = User.find(token[0]['user_id']) || nil
      render json: { message: 'no user logged in' } unless @user
      if @user.profile_type == 'Candidate'
        if @user.curriculum
          render json: { user: { name: @user.profile.name, image: @user.profile.image_url, generalInfo: @user, jobsApplied: @user.profile.jobs_applied }, curriculum: { header: @user.curriculum, pastJobs: @user.curriculum.jobs, address: @user.curriculum.candidate_address, personal: @user.curriculum.candidate_personal }, interviews: @user.profile.interviews.as_json(include: %i[company candidate job_offer]) }
        else
          render json: { user: { generalInfo: @user, image: @user.profile.image_url, name: @user.profile.name, jobsApplied: @user.profile.jobs_applied } }
        end
      elsif @user.profile_type == 'Company'
        render json: { user: { name: @user.profile.name, image: @user.profile.image_url, generalInfo: @user }, companyInfo: { header: @user.profile.header, jobOffers: @user.job_offers.as_json(include: [{ candidates: { include: { user: { include: { curriculum: { include: %i[candidate_address candidate_personal] } }, only: %i[email id image_url] } }, only: %i[name id image_url] } }, :approved]), address: @user.profile.company_address, personal: @user.profile.company_personal }, interviews: @user.profile.interviews.as_json(include: %i[company candidate job_offer]) }

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
