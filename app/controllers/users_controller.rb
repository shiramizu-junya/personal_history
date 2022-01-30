class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    # ログイン済みユーザーの場合はユーザー登録画面を表示しない
    login_decision
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # ユーザー登録後の自動ログイン
      auto_login(@user)
      redirect_to my_histories_path, success: t(".success")
    else
      flash.now[:danger] = t(".fail")
      render :new
    end
  end

  def destroy
    user = User.find_by(uuid: params[:id])
    user.destroy!
    redirect_to root_url, success: t(".success")
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
