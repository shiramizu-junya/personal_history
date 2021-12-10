class MyHistoriesController < ApplicationController
  include Pagy::Backend
  skip_before_action :require_login, only: [:index]

  def index
    @pagy, @my_histories = pagy(MyHistory.published.includes(:user).order(created_at: :desc))
  end

  def show; end

  def new; end

  private

end
