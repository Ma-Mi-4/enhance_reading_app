module RequestLoginHelper
  def request_login(user)
    post login_path, params: {
      email: user.email,
      password: "password"
    }
    follow_redirect! if response.redirect?
  end
end

RSpec.configure do |config|
  config.include RequestLoginHelper, type: :request
end
