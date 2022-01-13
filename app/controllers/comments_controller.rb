class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(my_history_id: params[:my_history_id])
  end
end
