module LoginHelper
  def login_as(user)
    visit login_path

    fill_in "email", with: user.email
    fill_in "password", with: "password123"
    click_button "ログイン"

    # Sorcery のログイン成功後は root_path にリダイレクトされるので、
    # URL で判定する方が堅牢
    expect(page).to have_current_path(root_path)
  end
end
