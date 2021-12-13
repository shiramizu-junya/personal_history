class Api::MyHistoriesController < ApplicationController
  before_action :set_my_history, only: %i[update]

  def create
    return render json: {:errors=>{:exists=>["既に自分史は作成済みです。"]}}, status: :bad_request if current_user.my_history.present?

    @my_history = current_user.build_my_history(my_history_params)

    if @my_history.save
      render json: @my_history, each_serializer: MyHistorySerializer, status: :ok
    else
      render json: { errors: @my_history.errors.keys.map { |key| [key, @my_history.errors.full_messages_for(key)]}.to_h }, status: :bad_request
    end
  end

  def update
    if @my_history.update(my_history_params)
      respond_to do |format|
        format.json { render json: { redirect: my_history_url(@my_history) } }
      end
    else
      render json: { errors: @my_history.errors.keys.map { |key| [key, @my_history.errors.full_messages_for(key)]}.to_h }, status: :bad_request
    end
  end

  private

  def set_my_history
    @my_history = current_user.my_history;
  end

  def my_history_params
    params.require(:my_history).permit(:title, :status)
  end
end
