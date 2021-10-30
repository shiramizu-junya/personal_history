class Api::ProfilesController < ApplicationController
  before_action :set_profile, only: %i[show]
  before_action :set_user, only: %i[update]

  def show
    render json: @user
  end

  def update
    if @user.update(user_params)
      render json: @user, each_serializer: UserSerializer, status: :ok
    else
      render json: { errors: @user.errors.keys.map { |key| [key, @user.errors.full_messages_for(key)]}.to_h }, status: :bad_request
    end
  end

  private

  def set_profile
    @user = User.select(:id, :name, :birthday, :gender).find(current_user.id)
  end

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:profile).permit(:birthday, :gender)
  end
end
