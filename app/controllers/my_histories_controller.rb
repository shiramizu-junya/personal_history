class MyHistoriesController < ApplicationController
  # before_action :set_my_history, only: %i[update]
  skip_before_action :require_login, only: [:index]

  def index; end

  def show; end

  def new; end

  # def update
  #   if @my_history.update(my_history_params)
  #     redirect_to @my_history, success: t('defaults.message.my_history_crate', item: MyHistory.model_name.human)
  #   else
  #     render json: { errors: @my_history.errors.keys.map { |key| [key, @my_history.errors.full_messages_for(key)]}.to_h }, status: :bad_request
  #   end
  # end

  private

  # def set_my_history
  #   @my_history = current_user.my_histories.find(params[:id])
  # end

  # def my_history_params
  #   params.require(:my_history).permit(:status)
  # end
end
