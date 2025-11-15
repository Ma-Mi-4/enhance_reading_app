class QuizzesController < ApplicationController
  before_action :require_login
  before_action :load_quiz_data, only: [:show, :explanation] 
  include StudyTimeTracker

  def show
  end

  def explanation
    save_study_time(params[:id], params[:study_seconds].to_i, review: true)
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
