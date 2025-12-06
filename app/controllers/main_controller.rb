class MainController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
    # ログインしていないときは @question_set は使わないので何もしない
    return unless current_user

    # レベル未設定なら問題は出さない（ビュー側で案内文を出す）
    return if current_user.level.blank?

    # レベルが設定されている場合だけ、そのレベルの問題セットから1件取得
    @question_set = QuestionSet.where(level: current_user.level).sample
  end
end
