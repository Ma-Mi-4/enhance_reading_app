class UserMailer < ApplicationMailer
  def reset_password_email(user)
    @user = user
    @url = edit_password_reset_url(@user.reset_password_token)
    mail(to: @user.email, subject: 'パスワードリセット')
  end

  def password_changed(user)
    @user = user
    mail(to: @user.email, subject: 'パスワードが変更されました')
  end
end
