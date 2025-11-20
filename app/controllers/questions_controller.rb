class QuestionsController < ApplicationController
  before_action :require_login
  before_action :load_questions_data, only: [:show, :explanation]
  include StudyTimeTracker

  def show
    @id = params[:id] || "001"
  end

  def explanation
    Rails.logger.debug "Params received: #{params.inspect}"
    seconds = params[:study_seconds].to_i
    minutes = (seconds / 60.0).round
    today = Date.today

    record = StudyRecord.find_or_initialize_by(user: current_user, date: today)
    record.minutes ||= 0
    record.minutes += minutes

    if params[:accuracy].present?
      record.accuracy = params[:accuracy].to_f
      Rails.logger.debug "Assigned accuracy: #{record.accuracy}"
      record.estimated_score = 500 + (800 - 500) * record.accuracy
      record.estimated_score = (record.estimated_score / 5.0).round * 5
    end

    saved = record.save
    p "accuracy = #{record.accuracy}"
    p "estimated_score = #{record.estimated_score}"
    p "saved = #{saved}"
    Rails.logger.debug "StudyRecord saved: #{saved}, record: #{record.inspect}"
  end

  def answer
    save_study_record(
      seconds: params[:study_seconds].to_i,
      accuracy: params[:accuracy]
    )

    redirect_to next_question_path
  end

  private

  def load_questions_data
    level = current_user.level
    level = params[:level] if params[:level].present?
    file_path = Rails.root.join("data/part7/level#{level}/part7_level#{level}_001.json")

    if File.exist?(file_path)
      @questions_data = JSON.parse(File.read(file_path))
    else
      @questions_data = {
        "title" => "問題データが見つかりません",
        "text" => "",
        "questions" => []
      }
    end
  rescue JSON::ParserError
    @questions_data = {
      "title" => "JSON読み込みエラー",
      "text" => "",
      "questions" => []
    }
  end
end
