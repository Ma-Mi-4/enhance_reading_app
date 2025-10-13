class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "ログイン成功"
    else
      flash.now[:alert] = "Emailまたはパスワードが違います"
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_path, notice: "ログアウトしました"
  end
end

