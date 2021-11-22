class Api::CategoriesController < ApplicationController
  def index
    @category = Category.all
    render json: @category, status: :ok
  end
end
