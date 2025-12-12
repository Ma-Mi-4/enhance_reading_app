module DisableSorcery
  def require_login
    true
  end

  def current_user
    User.first || FactoryBot.create(:user)
  end

  def not_authenticated
    false
  end
end

RSpec.configure do |config|
  config.before(:each, type: :request) do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(User.first || FactoryBot.create(:user))

    allow_any_instance_of(ApplicationController)
      .to receive(:require_login).and_return(true)

    allow_any_instance_of(ApplicationController)
      .to receive(:not_authenticated).and_return(false)
  end
end
