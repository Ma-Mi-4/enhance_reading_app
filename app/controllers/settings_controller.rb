class SettingsController < ApplicationController
  skip_before_action :require_login, only: [:level, :update_level], if: -> { params[:new_registration].present? && params[:id].present? }
  before_action :set_user, only: [:level, :update_level]
  before_action :set_notification_setting, only: [:notification, :update_notification]

  def level
    @new_registration = params[:new_registration].present?
  end

  def update_level
    if @user.update(level_params)
      redirect_to main_path, notice: "レベル設定が完了しました"
    else
      flash.now[:alert] = "レベル設定に失敗しました"
      render :level, status: :unprocessable_entity
    end
  end

  def notification
  end

  def update_notification
    if @notification_setting.update(notification_setting_params)
      redirect_to settings_notification_path, notice: "通知設定を保存しました"
    else
      flash.now[:alert] = "通知設定を保存できませんでした"
      render :notification, status: :unprocessable_entity
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

  def set_notification_setting
    @notification_setting = current_user.notification_setting || current_user.build_notification_setting
  end

  def notification_setting_params
    params.require(:notification_setting).permit(:enabled, :notify_time)
  end
end
