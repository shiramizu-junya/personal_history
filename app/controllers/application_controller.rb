class ApplicationController < ActionController::Base
  add_flash_types :success, :danger
  before_action :require_login

  private

  def not_authenticated
    flash[:warning] = t("defaults.message.require_login")
    redirect_to login_path
  end
end
