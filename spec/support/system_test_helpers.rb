module SystemTestHelpers
  def system_login_as(user)
    visit login_path

    fill_in "email", with: user.email
    fill_in "password", with: "password123"
    click_button "ログイン"
  end
end

RSpec.configure do |config|
  config.include SystemTestHelpers, type: :system
end
