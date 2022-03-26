class Api::ProfilesController < ApplicationController
  before_action :set_user, only: %i[show update]

  def show
    render json: @user, each_serializer: UserSerializer, status: :ok
  end

  def update
    if @user.update(user_params)
      render json: @user, each_serializer: UserSerializer, status: :ok
    else
      render json: { errors: @user.errors.keys.index_with { |key| @user.errors.full_messages_for(key) } }, status: :bad_request
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:profile).permit(:birthday, :gender)
  end
end
