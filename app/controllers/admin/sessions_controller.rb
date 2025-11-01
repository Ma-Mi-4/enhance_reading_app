class Admin::SessionsController < ApplicationController
  include Sorcery::Controller
  layout "admin"
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    user = login(params[:email], params[:password])
    if user
      if user.admin?
        session[:admin_user_id] = user.id
        redirect_to admin_root_path, notice: "管理者としてログインしました"
      else
        redirect_to root_path, notice: "ログインしました"
      end
    else
      flash.now[:alert] = "Emailまたはパスワードが違います"
      render :new
    end
  end

  def destroy
    session[:admin_user_id] = nil 
    redirect_to root_path, notice: "ログアウトしました"
  end
end
