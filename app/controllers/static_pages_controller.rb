class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[top terms privacy]

  def top; end

  def terms; end

  def privacy; end
end
