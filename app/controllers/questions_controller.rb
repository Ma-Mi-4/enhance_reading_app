class QuestionsController < ApplicationController
  before_action :require_login

  def show
    level = params[:level] || '600'
    file_path = Rails.root.join("data/part7/level#{level}/part7_level#{level}_001.json")

    if File.exist?(file_path)
      file = File.read(file_path)
      @questions_data = JSON.parse(file)
    else
      # JSONがなかった場合も空の構造で初期化
      @questions_data = {
        "title" => "問題データが見つかりません",
        "text" => "",
        "questions" => []
      }
    end
  rescue JSON::ParserError
    # JSON形式が壊れている場合の安全策
    @questions_data = {
      "title" => "JSON読み込みエラー",
      "text" => "",
      "questions" => []
    }
  end
end
