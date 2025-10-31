class Admin::MainController < ApplicationController
  before_action :require_admin_login

  private

  def require_admin_login
    unless current_user&.admin?
      redirect_to root_path, alert: "管理者のみアクセス可能です"
    end
  end
end
