class CurriculumsController < ApplicationController
  def create
    byebug
    @curriculum = curriculum.new(params_curriculum)
    if @curriculum
      render json: @curriculum
    else  
      render json: { message: 'error'}
    end
  end

  private

  def params_curriculum
    params.require(:curriculum).permit(:about_me)
  end
end
