class CommentsController < ApplicationController
  def create
    @my_history = MyHistory.find_by(uuid: params[:comment][:uuid])
    @comment = current_user.comments.build(comment_params)
    @comment.save
  end

  def update
    @comment = current_user.comments.find(params[:id])
    @uuid = @comment.my_history.uuid
    @name = @comment.my_history_create_user.name
    if @comment.update(comment_update_params)
      render json: { comment: @comment, uuid: @uuid, name: @name }, status: :ok
    else
      render json: { comment: @comment, errors: { messages: @comment.errors.full_messages } }, status: :bad_request
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(my_history_id: params[:my_history_id])
  end

  def comment_update_params
    params.require(:comment).permit(:body)
  end
end
