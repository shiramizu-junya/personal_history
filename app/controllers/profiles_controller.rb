class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def show
  end

  def edit; end

  def update
  end

  private

  def set_user
    # @user = current_userを使うと、updateアクションに失敗した時に_header.html.erbのユーザー名を表示するとこに不具合が出る
    @user = User.find(current_user.id)
  end

  def user_params; end
end
