module LoginHelper
  def login_as(user, password:)
    visit login_path
    fill_in "email", with: user.email
    fill_in "password", with: password
    click_button "ログイン"
  end
end

# ★ LoginHelper は request spec 専用にする（ここが超重要！！！）
RSpec.configure do |config|
  config.include LoginHelper, type: :request
end
