module StudyTimeTracker
  extend ActiveSupport::Concern

  private

  def save_study_time(question_id, seconds, review: false)
    StudyTime.create(
      user: current_user,
      question_id: question_id,
      seconds: seconds,
      review: review
    )
  end
end