class Api::EventsController < ApplicationController
  before_action :set_event, only: %i[update destroy]

  def create
    @my_history = current_user.my_history
    @event = @my_history.events.build(event_params)

    if @event.save
      render json: @event, each_serializer: EventSerializer, status: :ok
    else
      render json: { errors: @event.errors.keys.index_with { |key| @event.errors.full_messages_for(key) } }, status: :bad_request
    end
  end

  def update
    if @event.update(event_params)
      render json: @event, each_serializer: EventSerializer, status: :ok
    else
      render json: { errors: @event.errors.keys.index_with { |key| @event.errors.full_messages_for(key) } }, status: :bad_request
    end
  end

  def destroy
    @event.destroy!
    render json: @event, each_serializer: EventSerializer, status: :ok
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:age, :title, :episode, :happiness)
  end
end
