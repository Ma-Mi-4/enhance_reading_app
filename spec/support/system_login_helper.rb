module SystemLoginHelper
  def system_login_as(user)
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "ログイン"
  end
end

RSpec.configure do |config|
  config.include SystemLoginHelper, type: :system
end
