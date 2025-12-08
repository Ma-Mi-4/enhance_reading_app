class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  skip_before_action :require_login, only: [:new, :create, :oauth, :oauth_callback]
  skip_forgery_protection only: [:create, :oauth_callback]

  def new
  end

  def create
    user = login(params[:email], params[:password])
    if user
      redirect_to root_path, notice: "ログイン成功"
    else
      flash[:alert] = "メールアドレスまたはパスワードが違います"
      render :new, status: :unprocessable_entity
    end
  end

  def oauth
    login_at(params[:provider])
  end

  def oauth_callback
    provider = params[:provider]

    user = login_from(provider)

    unless user
      user = create_from(provider)

      user.email&.downcase!
      user.level ||= 500

      user.save!
    end

    reset_session
    auto_login(user)
    redirect_to root_path, notice: "#{provider.titleize}でログインしました"

  rescue => e
    Rails.logger.error(e)
    redirect_to login_path, alert: "Googleログインに失敗しました"
  end

  def destroy
    logout
    redirect_to root_path, notice: "ログアウトしました"
  end
end
