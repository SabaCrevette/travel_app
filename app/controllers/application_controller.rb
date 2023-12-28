class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def not_authenticated
    flash[:alert] = t('defaults.require_login')
    redirect_to login_path
  end
end
