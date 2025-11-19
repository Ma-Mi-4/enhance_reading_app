class QuizzesController < ApplicationController
  before_action :require_login
  before_action :load_quiz_data, only: [:show, :explanation] 
  include StudyTimeTracker

  def show
    @id = params[:id] || "001"
  end

  def explanation
    seconds = params[:study_seconds].to_i
    save_study_time(params[:id], seconds, review: false)

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
      accuracy: params[:accuracy],
      review: true
    )

    redirect_to next_quiz_path
  end

  private

  def load_quiz_data
    level = current_user.level.to_s
    level = params[:level] if params[:level].present?
    id = params[:id] || '001'
    file_path = Rails.root.join("data/quiz/level#{level}/quiz_level#{level}_#{id}.json")

    if File.exist?(file_path)
      @quiz_data = JSON.parse(File.read(file_path))
    else
      @quiz_data = { "title" => "復習問題データが見つかりません", "questions" => [] }
    end
  rescue JSON::ParserError
    @quiz_data = { "title" => "JSON読み込みエラー", "questions" => [] }
  end
end
