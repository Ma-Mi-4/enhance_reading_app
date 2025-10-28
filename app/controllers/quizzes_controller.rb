class QuizzesController < ApplicationController
  before_action :require_login

  def show
    level = params[:level] || '600'
    id = params[:id] || '001'
    file_path = Rails.root.join("data/quiz/level#{level}/quiz_level#{level}_#{id}.json")

    if File.exist?(file_path)
      file = File.read(file_path)
      @quiz_data = JSON.parse(file)
    else
      @quiz_data = {
        "title" => "復習問題データが見つかりません",
        "questions" => []
      }
    end
  rescue JSON::ParserError
    @quiz_data = {
      "title" => "JSON読み込みエラー",
      "questions" => []
    }
  end
end
