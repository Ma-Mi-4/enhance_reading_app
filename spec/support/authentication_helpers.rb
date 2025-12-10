module AuthenticationHelpers
  def login_user(user = create(:user))
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)

    allow_any_instance_of(ApplicationController)
      .to receive(:require_login).and_return(true)

    allow_any_instance_of(ApplicationController)
      .to receive(:not_authenticated).and_return(false)
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelpers, type: :request
end
