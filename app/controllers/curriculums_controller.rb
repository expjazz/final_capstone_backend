class CurriculumsController < ApplicationController
  before_action :require_current_user

  def create
    # @curriculum = Curriculum.new
    address = CandidateAddress.create(params_address)
    personal = CandidatePersonal.create(params_personal)
    @curriculum = Curriculum.new(params_curriculum)
    @curriculum.candidate_personal = personal
    @curriculum.candidate_address = address
    if params[:curriculum][:jobs]
      ind = 0
      params[:curriculum][:jobs].size.times do
        @new_job = Job.create(start: params[:curriculum][:jobs][ind][:start], end: params[:curriculum][:jobs][ind][:end], name: params[:curriculum][:jobs][ind][:name])
        @curriculum.jobs.push(@new_job)
        ind += 1
      end
    end
    token = info_current_user
    @curriculum.user_id = token[0]['user_id']

    if @curriculum.save
      render json: { header: @curriculum, pastJobs: @curriculum.jobs, address: @curriculum.candidate_address, personal: @curriculum.candidate_personal }
    else
      render json: { message: @curriculum.errors.full_messages }
    end
  end

  def update
    address = CandidateAddress.create(params_address)
    personal = CandidatePersonal.create(params_personal)
    token = JWT.decode(cookies[:token], ENV['DEVISE_SECRET_KEY'])

    @user = User.find(token[0]['user_id'])

    @user.curriculum.update(params_curriculum)
    @user.curriculum.candidate_personal.update(params_personal)
    @user.curriculum.candidate_address.update(params_address)
    if params[:curriculum][:jobs]
      @user.curriculum.jobs.destroy_all
      ind = 0
      params[:curriculum][:jobs].size.times do
        @new_job = Job.create(start: params[:curriculum][:jobs][ind][:start], end: params[:curriculum][:jobs][ind][:end], name: params[:curriculum][:jobs][ind][:name])
        @user.curriculum.jobs.push(@new_job)
        ind += 1
      end
    end
    if @user.curriculum.save
      render json: { header: @user.curriculum, pastJobs: @user.curriculum.jobs, address: @user.curriculum.candidate_address, personal: @user.curriculum.candidate_personal }
    else
      render json: { message: @curriculum.errors.full_messages }
    end
  end

  private

  def params_curriculum
    params.require(:curriculum).permit(:about_me)
  end

  def params_address
    params[:curriculum].require(:candidate_address).permit(:country, :cep, :state, :city, :hood, :street, :cel)
  end

  def params_personal
    params[:curriculum].require(:candidate_personal).permit(:children, :married, :cpf, :race, :nationality)
  end
end

# candidate_address: %i[country cep state city hood street cel], candidate_personal: %i[children married cpf race nationality])
