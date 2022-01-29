class Api::MyHistoriesController < ApplicationController
  before_action :set_my_history, only: %i[edit update graph_data graph_image_upload]

  def edit
    render json: @my_history, each_serializer: MyHistorySerializer, include: %i[events], status: :ok
  end

  def create
    return render json: { errors: { exists: ["既に自分史は作成済みです。"] } }, status: :bad_request if current_user.my_history.present?

    @my_history = current_user.build_my_history(my_history_params)

    if @my_history.save
      render json: @my_history, each_serializer: MyHistorySerializer, status: :ok
    else
      render json: { errors: @my_history.errors.keys.map { |key| [key, @my_history.errors.full_messages_for(key)]}.to_h }, status: :bad_request
    end
  end

  def update
    if @my_history.update(my_history_params)
      render json: @my_history, each_serializer: MyHistorySerializer, status: :ok
    else
      render json: { errors: @my_history.errors.keys.map { |key| [key, @my_history.errors.full_messages_for(key)]}.to_h }, status: :bad_request
    end
  end

  def graph_data
    group_events = @my_history.events.order(age: :asc).group_by &:age
    @graph_events = Event.age_happiness_average(group_events)
    render json: @graph_events, status: :ok
  end

  def graph_image_upload
    @my_history.graph_image = params[:my_history][:graph_image]
    @my_history.save!
    head :ok
  end

  private

  def set_my_history
    @my_history = current_user.my_history
  end

  def my_history_params
    params.require(:my_history).permit(:title)
  end
end
