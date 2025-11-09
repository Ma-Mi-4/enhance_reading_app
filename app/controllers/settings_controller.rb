class SettingsController < ApplicationController
  skip_before_action :require_login, only: [:level, :update_level], if: -> { params[:new_registration].present? && params[:id].present? }
  before_action :set_user, only: [:level, :update_level]

  def level
    @new_registration = params[:new_registration].present?
  end

  def update_level
    if @user.update(level_params)
      if params[:new_registration].present?
        redirect_to login_path, notice: "レベル設定が完了しました。ログインしてください"
      else
        redirect_to settings_level_path, notice: "レベル設定を更新しました"
      end
    else
      flash.now[:alert] = "レベル設定に失敗しました"
      render :level, status: :unprocessable_entity
    end
  end

  private

  def set_user
    if params[:id].present?
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  def level_params
    params.require(:user).permit(:level)
  end
end
