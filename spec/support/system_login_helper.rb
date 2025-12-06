module SystemLoginHelper
  def system_login_as(user)
    puts "[DEBUG] system_login_as called for #{user.email}"

    visit login_path
    fill_in "email", with: user.email
    fill_in "password", with: user.raw_password
    click_button "ログイン"
  end
end

RSpec.configure do |config|
  config.include SystemLoginHelper, type: :system
end
