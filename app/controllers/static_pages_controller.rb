class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[top terms]

  def top; end

  def terms; end
end
