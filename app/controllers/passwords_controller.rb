class PasswordsController < ApplicationController
  before_action :require_login

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(password: params[:password], password_confirmation: params[:password_confirmation])
      UserMailer.password_changed(@user).deliver_now
      redirect_to settings_account_path, notice: "パスワードが更新されました"
    else
      flash.now[:alert] = "パスワードの更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end
end
