class Api::EventsController < ApplicationController
  def create
    @my_history = MyHistory.find(params[:history_id])
    @event = @my_history.events.build(event_params)

    if @event.save
      render json: @event, each_serializer: EventSerializer, status: :ok
    else
      render json: { errors: @event.errors.keys.map { |key| [key, @event.errors.full_messages_for(key)]}.to_h }, status: :bad_request
    end
  end

  def upate; end

  private

  def event_params
    params.require(:event).permit(:age, :title, :episode, :happiness)
  end
end
