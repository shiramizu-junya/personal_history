class LikesController < ApplicationController
  def create
    @my_history = MyHistory.find(params[:my_history_id])
    current_user.like(@my_history)
  end

  def destroy
    @my_history = current_user.likes.find(params[:id]).my_history
    current_user.unlike(@my_history)
  end
end
