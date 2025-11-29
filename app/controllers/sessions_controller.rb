class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :callback, :google]
  skip_before_action :verify_authenticity_token, only: [:google]

  def new; end

  def create
    user = login(params[:email], params[:password])
    if user
      redirect_to root_path, notice: "ログイン成功"
    else
      flash.now[:alert] = "Emailまたはパスワードが違います"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to login_path, notice: "ログアウトしました"
  end

  def callback
    render :google_callback
  end

  def google
    access_token = params[:access_token]

    if access_token.blank?
      render json: { error: "access_token がありません" }, status: :unprocessable_entity
      return
    end

    user_info = SupabaseService.get_user_from_access_token(access_token)
    email = user_info[:email]

    if email.blank?
      render json: { error: "Googleからメールアドレスが取得できませんでした" }, status: :unprocessable_entity
      return
    end

    user = User.find_or_create_by(email: email) do |u|
      u.password = SecureRandom.hex(10)
    end

    auto_login(user)

    render json: { message: "OK" }, status: :ok
  end
end
