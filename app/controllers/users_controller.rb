class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  #  ユーザー新規作成画面
  def new
    @user = User.new
  end

  # ユーザー新規作成機能
  def create
    @user = User.new(user_params)

    if @user.save
      # ユーザー登録後の自動ログイン
      auto_login(@user)
      redirect_to tracks_path, success: "ユーザー登録に成功しました" #t('.success')
    else
      flash.now[:danger] = "ユーザー登録に失敗しました" #t('.fail')
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
