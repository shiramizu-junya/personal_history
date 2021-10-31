class Api::MyHistoriesController < ApplicationController

  def create
    @my_history = current_user.my_histories.build(my_history_params)

    if @my_history.save
      render json: @my_history, each_serializer: MyHistorySerializer, status: :ok
    else
      render json: { errors: @my_history.errors.keys.map { |key| [key, @my_history.errors.full_messages_for(key)]}.to_h }, status: :bad_request
    end
  end

  def update

  end

  private

  def my_history_params
    params.require(:history).permit(:title)
  end
end
