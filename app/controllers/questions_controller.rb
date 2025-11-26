class QuestionsController < ApplicationController
  before_action :require_login
  include StudyTimeTracker

  def show
    @question_set = QuestionSet.find(params[:id])
    @questions    = @question_set.questions.order(:order)
  end

  def explanation
    @question_set = QuestionSet.find(params[:id])
    @questions    = @question_set.questions.order(:order)

    seconds = params[:study_seconds].to_i
    minutes = (seconds / 60.0).round
    today = Date.today

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
      accuracy: params[:accuracy]
    )

    redirect_to next_question_path
  end
end
