class NotificationMailer < ApplicationMailer
  def notify(user)
    @user = user
    mail(to: @user.email, subject: "通知テスト")
  end
end
