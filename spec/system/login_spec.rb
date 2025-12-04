require 'rails_helper'

RSpec.describe "Login", type: :system do
  before do
    # Main#index が読み込めるように最低限の QuestionSet を作成
    FactoryBot.create(:question_set, level: 500)
  end

  it "ログインに成功する" do
    password = "password123"
    user = FactoryBot.create(:user, raw_password: password)

    visit login_path

    fill_in "email", with: user.email
    fill_in "password", with: password
    click_button "ログイン"

    expect(page).to have_current_path(root_path)
      .or have_content("ログイン成功")
  end

  it "ログインに失敗する" do
    visit login_path

    fill_in "email", with: "wrong@example.com"
    fill_in "password", with: "wrongpass"
    click_button "ログイン"

    expect(page).to have_content("メールアドレスまたはパスワードが違います")
  end
end
