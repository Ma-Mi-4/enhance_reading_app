class PasswordResetsController < ApplicationController
    skip_before_action :require_login

  def new; end

  def create
    @user = User.find_by(email: params[:email])
    @user&.deliver_reset_password_instructions!
    redirect_to login_path, success: "成功しました"
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)
    not_authenticated if @user.blank?
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)
    return not_authenticated if @user.blank?

    if @user.update(password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
      redirect_to login_path, success: "パスワードが更新されました"
    else
      flash.now[:danger] = "パスワードの更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end
end
