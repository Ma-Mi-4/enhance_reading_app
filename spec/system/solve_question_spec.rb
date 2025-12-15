require "rails_helper"

RSpec.describe "Question solving flow", type: :system do
  let(:password) { "password" }
  let(:user) { create(:user, level: 500, password: password, password_confirmation: password) }

  let!(:question_set) do
    create(:question_set, :with_questions,
           level: 500,
           questions_count: 3,
           title: "Test Question Set")
  end

  let!(:extra_set) do
    create(:question_set, :with_questions, level: 500)
  end

  before do
    visit login_path

    expect(page).not_to have_content("ログイン")

    fill_in "email", with: user.email
    fill_in "password", with: password

    click_button "ログイン"
  end

  it "問題を解き、解説ページへ進み、StudyRecord が保存される" do
    visit question_path(question_set)

    expect(page).to have_content(question_set.title)

    correct_indexes = question_set.questions.order(:order).pluck(:correct_index)

    correct_indexes.each_with_index do |correct, i|
      choose("q#{i}_choice#{correct}")
    end

    find("#accuracy_field", visible: false).set(100)
    find("#study_seconds", visible: false).set(120)

    click_button "解説を見る"

    expect(page).to have_content("解説")

    record = StudyRecord.find_by(user: user, date: Date.current)
    expect(record).not_to be_nil
  end
end
