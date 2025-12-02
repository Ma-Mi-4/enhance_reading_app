class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :oauth, :oauth_callback]
  skip_forgery_protection only: [:create, :oauth_callback]

  def new
  end

  def create
    user = login(params[:email], params[:password])
    if user
      redirect_to root_path, notice: "ログイン成功"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが違います"
      render :new, status: :unprocessable_entity
    end
  end

  def oauth
    login_at(params[:provider])
  end

  def oauth_callback
    provider = params[:provider]

    if (user = login_from(provider))
      auto_login(user)
      redirect_to root_path, notice: "#{provider.titleize}でログインしました"
      return
    end

    user = create_from(provider)

    user.update(email: user.email&.downcase) if user.email.present?

    reset_session
    auto_login(user)

    redirect_to root_path, notice: "#{provider.titleize}で新規登録しました"

  rescue => e
    Rails.logger.error(e)
    redirect_to login_path, alert: "Googleログインに失敗しました"
  end

  def destroy
    logout
    redirect_to root_path, notice: "ログアウトしました"
  end
end
