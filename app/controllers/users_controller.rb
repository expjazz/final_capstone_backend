class UsersController < ApplicationController
  include ActionController::Cookies
  before_action :require_current_user

  def index
    @users = User.all
    render json: @users
  end
end
