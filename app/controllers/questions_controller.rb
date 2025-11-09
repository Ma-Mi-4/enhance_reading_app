class QuestionsController < ApplicationController
  before_action :require_login
  before_action :load_questions_data, only: [:show, :explanation]

  def show
    @id = params[:id] || "001"
  end

  def explanation
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
