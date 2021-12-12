class MyHistoriesController < ApplicationController
  include Pagy::Backend
  skip_before_action :require_login, only: [:index]

  def index
    @q = MyHistory.ransack(params[:q])
    @pagy, @my_histories = pagy(@q.result(distinct: true).includes(:user).order(created_at: :desc))
  end

  def show; end

  def new; end

  private

end
