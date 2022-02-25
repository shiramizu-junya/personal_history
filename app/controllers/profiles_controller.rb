class ProfilesController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def show
    @my_history = @user.my_history
    # binding.pry
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: t("defaults.message.updated", item: t("profiles.edit.profile"))
    else
      flash.now[:danger] = t("defaults.message.not_updated", item: t("profiles.edit.profile"))
      render :edit
    end
  end

  private

  def set_user
    # @user = current_userを使うと、updateアクションに失敗した時に_header.html.erbのユーザー名を表示するとこに不具合が出る
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :email, :birthday, :gender, :avatar, :avatar_cache)
  end
end
