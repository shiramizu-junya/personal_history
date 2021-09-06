class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # ユーザー登録後の自動ログイン
      auto_login(@user)
      redirect_to tracks_path, success: t(".success")
    else
      flash.now[:danger] = t(".fail")
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
