class ProfilesController < ApplicationController
  def show
  end

  def edit; end

  def update
  end

  private

  def set_user
    # @user = current_userを使うと、updateアクションに失敗した時にedit.html.erbの_header.html.erbのユーザー名を表示するとこに不具合が出る
    @user = User.find(current_user.id)
  end
end
