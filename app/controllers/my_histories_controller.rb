class MyHistoriesController < ApplicationController
  include Pagy::Backend
  before_action :set_my_history, only: %i[update]
  skip_before_action :require_login, only: %i[index]

  def index
    @q = MyHistory.ransack(params[:q])
    @pagy, @my_histories = pagy(@q.result(distinct: true).includes(:user).order(created_at: :desc))
  end

  def show; end

  def new; end

  def update
    if @my_history.update(my_history_params)
      render json: { redirect: my_history_url(@my_history.uuid) }
    else
      render json: { errors: @my_history.errors.keys.map { |key| [key, @my_history.errors.full_messages_for(key)]}.to_h }, status: :bad_request
    end
  end

  private

  def set_my_history
    @my_history = MyHistory.find(params[:id])
  end

  def my_history_params
    params.require(:my_history).permit(:status)
  end
end
