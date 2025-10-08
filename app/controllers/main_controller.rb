class MainController < ApplicationController
  before_action :require_login

  def index
  end

  private

  def require_login
    unless current_user
      redirect_to login_path, alert: 'ログインしてください'
    end
  end
end
