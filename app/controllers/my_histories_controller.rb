class MyHistoriesController < ApplicationController
  include Pagy::Backend
  before_action :set_my_history, only: %i[update]
  skip_before_action :require_login, only: %i[index show]

  def index
    @q = MyHistory.ransack(params[:q])
    @pagy, @my_histories = pagy(@q.result(distinct: true).includes(:user).published.order(created_at: :desc))
  end

  def show
    @my_history = MyHistory.find_by(uuid: params[:id])
    if @my_history.unpublished? && !current_user.own?(@my_history)
      redirect_to my_histories_path, danger: t("defaults.message.unpublished")
    end
    @comment = Comment.new
    @comments = @my_history.comments.includes(:user).order(created_at: :asc)
    @user = @my_history.user
    @group_events = @my_history.events.order(age: :asc).group_by &:age
    @graph_events = Event.age_happiness_average(@group_events)
  end

  def new; end

  def edit; end

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
