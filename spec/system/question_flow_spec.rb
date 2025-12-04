require "rails_helper"

RSpec.describe "Question solving flow", type: :system do
  let(:user) { create(:user) }
  let(:question_set) { create(:question_set) }

  let!(:question) do
    create(:question,
      question_set: question_set,
      order: 1,
      body: "Sample body",
      choices_text: ["A", "B", "C", "D"],
      correct_index: 0
    )
  end

  before do
    system_login_as(user)
  end

  it "ログイン後に問題ページにアクセスできる" do
    visit question_path(question_set.id)
    expect(page).to have_content("Sample body")
    expect(page).to have_selector("li", text: "A")
  end
end
