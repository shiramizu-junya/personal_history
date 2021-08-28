class UserSessionsController < ApplicationController
  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_back_or_to tracks_path #, success: t('.success')
    else
      # flash.now[:danger] = t('.fail')
      render :new
    end
  end

  def destroy

  end
end