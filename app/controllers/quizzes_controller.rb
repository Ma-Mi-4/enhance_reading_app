class QuizzesController < ApplicationController
  before_action :require_login
  include StudyTimeTracker

  def show
    @quiz_set = QuizSet.find(params[:id])
    @quiz_questions = @quiz_set.quiz_questions.order(:order)
  end

  def explanation
    @quiz_set = QuizSet.find(params[:id])
    @quiz_questions = @quiz_set.quiz_questions.order(:order)

    seconds = params[:study_seconds].to_i
    minutes = (seconds / 60.0).round
    today = Date.current

    record = StudyRecord.find_or_initialize_by(user: current_user, date: today)
    record.minutes ||= 0
    record.minutes += minutes

    if params[:accuracy].present?
      record.accuracy = params[:accuracy].to_f
      record.estimated_score = 500 + (800 - 500) * record.accuracy
      record.estimated_score = (record.estimated_score / 5.0).round * 5
    end

    record.save
  end

  def answer
    save_study_record(
      seconds: params[:study_seconds].to_i,
      accuracy: params[:accuracy],
      review: true
    )

    redirect_to next_quiz_path
  end
end
