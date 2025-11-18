module StudyTimeTracker
  extend ActiveSupport::Concern

  private

  def save_study_time(question_id, seconds, review: false)
    return if seconds <= 0

    minutes = (seconds / 60.0).round
    today = Date.today

    record = StudyRecord.find_or_initialize_by(user: current_user, date: today)

    record.minutes ||= 0
    record.minutes += minutes

    record.save
  end
end
