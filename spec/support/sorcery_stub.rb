RSpec.configure do |config|
  config.before(:each, type: :request) do
    # current_user 偽装
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(create(:user))

    # require_login 無力化
    allow_any_instance_of(ApplicationController)
      .to receive(:require_login)
      .and_return(true)

    allow_any_instance_of(ApplicationController)
      .to receive(:not_authenticated)
      .and_return(false)
  end
end
