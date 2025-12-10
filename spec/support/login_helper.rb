module LoginHelper
  def login_as(user, password:)
    visit login_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: password
    click_button "ログイン"
  end
end

RSpec.configure do |config|
  config.include LoginHelper, type: :system
end
