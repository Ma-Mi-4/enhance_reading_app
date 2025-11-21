class NotificationService
  def self.send_scheduled_notifications
    now = Time.current
    current_hhmm = now.strftime("%H:%M")

    NotificationSetting.includes(:user)
                       .where(enabled: true)
                       .find_each do |setting|
      if setting.notify_time.strftime("%H:%M") == current_hhmm
        NotificationMailer.daily_reminder(setting.user, Question.order("RANDOM()").first).deliver_now
      end
    end
  end
end
