class EmailsController < ApplicationController
  before_action :require_login

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(email: params[:email])
      redirect_to settings_account_path, notice: "メールアドレスが更新されました"
    else
      flash.now[:alert] = "メールアドレスの更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end
end
