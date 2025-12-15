module DisableSorcery
  def require_login
    true
  end

  def current_user
    @current_user ||= User.first || FactoryBot.create(:user)
  end

  def not_authenticated
    true
  end
end

RSpec.configure do |config|
  config.before(:each, type: :request) do
    ApplicationController.prepend(DisableSorcery)
  end
end
