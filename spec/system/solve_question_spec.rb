require "rails_helper"

RSpec.describe "Question solving flow", type: :system, js: true do
  include LoginHelper

  let(:user) { create(:user, level: 500) }
  let!(:question_set) { create(:question_set, :with_questions, level: 500, questions_count: 3) }

  before do
    login_as(user)
  end

  it "問題を解き、解説ページへ進み、StudyRecord が保存される" do
    visit question_path(question_set)
    expect(page).to have_content(question_set.title)

    # 正解 index を DB から取得
    correct_indexes = question_set.questions.order(:order).pluck(:correct_index)

    # ラジオボタンにチェック
    correct_indexes.each_with_index do |correct, i|
      target_id = "q#{i}_choice#{correct}"
      expect(page).to have_selector("##{target_id}", visible: false)  # ← 要素の存在待ち
      page.execute_script("document.getElementById('#{target_id}').checked = true;")
    end

    # accuracy hidden field をセット（question / quiz 両対応）
    page.execute_script <<~JS
      const el = document.querySelector('input[id*="accuracy_field"]');
      if(el){ el.value = 100; }
    JS

    # 学習秒数も投入
    page.execute_script <<~JS
      const sec = document.getElementById('study_seconds');
      if(sec){ sec.value = 120; }
    JS

    # ボタン押下
    click_button "解説を見る"

    # 送信後の画面遷移を確実に待つ
    expect(page).to have_selector("body[data-page='explanation']", wait: 5)

    # 🔥 遷移を「確実に」待つ
    expect(page).to have_content("解説")

    # 🔥 URL の最終チェック（ignore_query 付き）
    expect(page).to have_current_path(explanation_question_path(question_set), ignore_query: true)

    # StudyRecord の保存確認
    record = StudyRecord.find_by(user: user, date: Date.today)
    expect(record).not_to be_nil
    expect(record.question_total).to eq(question_set.questions.count)
  end
end
