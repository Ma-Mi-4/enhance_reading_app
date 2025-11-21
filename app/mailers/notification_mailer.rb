class NotificationMailer < ApplicationMailer
  def daily_reminder(user, question)
    @user = user
    @question = question

    mail(
      to: @user.email,
      subject: "今日の学習リマインダー"
    )
  end
end
