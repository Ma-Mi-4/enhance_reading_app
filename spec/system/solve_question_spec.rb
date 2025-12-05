require "rails_helper"

RSpec.describe "Question solving flow", type: :system, js: true do
  include LoginHelper

  let(:user) { create(:user, level: 500, raw_password: "password") }
  let!(:question_set) { create(:question_set, :with_questions, level: 500, questions_count: 3) }

  before do
    # Main#index が正常動作するため最低1件必要
    create(:question_set, :with_questions, level: 500)

    login_as(user, password: "password")
  end

  it "問題を解き、解説ページへ進み、StudyRecord が保存される" do
    visit question_path(question_set)

    expect(page).to have_content(question_set.title)

    correct_indexes = question_set.questions.order(:order).pluck(:correct_index)

    correct_indexes.each_with_index do |correct, i|
      target_id = "q#{i}_choice#{correct}"
      page.execute_script("document.getElementById('#{target_id}').checked = true;")
    end

    page.execute_script("document.getElementById('accuracy_field').value = 100;")
    page.execute_script("document.getElementById('study_seconds').value = 120;")

    click_button "解説を見る"

    expect(page).to have_selector("body[data-page='explanation']", wait: 5)

    record = StudyRecord.find_by(user: user, date: Date.current)
    expect(record).not_to be_nil
  end
end
