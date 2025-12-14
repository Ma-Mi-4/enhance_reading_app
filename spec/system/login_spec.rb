require 'rails_helper'

RSpec.describe "Login", type: :system, js: true, system: true do
  before do
    create(:question_set, :with_questions, level: 500)
  end

  it "ログインに成功する" do
    user = create(:user, password: "password")

    visit login_path

    fill_in "email", with: user.email
    fill_in "password", with: "password"
    click_button "ログイン"

    expect(page).to have_content("ログアウト")
  end

  it "ログインに失敗する" do
    visit login_path

    fill_in "email", with: "wrong@example.com"
    fill_in "password", with: "wrongpass"
    click_button "ログイン"

    expect(page).to have_content("メールアドレスまたはパスワードが違います")
  end
end
