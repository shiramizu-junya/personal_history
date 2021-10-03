class PersonalHistoriesController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index; end

  def show; end

  def new; end

  def edit; end

  def create
    # @track = current_user.tracks.create
    # @event = @track.events.create(track_params)

  end

  def update; end

  def destroy; end

  private

  def track_params
    params.require(:track).permit(:age, :happiness, :episode)
  end
end
