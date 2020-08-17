class RegistrationsController < Devise::SessionsController
  respond_to :json
  def create
    @user = User.new(user_params)
    @user.profile = Candidate.new(candidate_params)
    @user.save
  end

  private

  def respond_with(resource, _opts = {})
    render json: resource
    end

  def respond_to_on_destroy
    head :ok
      end

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def candidate_params
    params.require(:candidate).permit(:name)
  end
end
