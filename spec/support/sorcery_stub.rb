RSpec.configure do |config|
  config.before(:each, type: :request) do
    user = FactoryBot.create(:user)

    # Sorcery の current_user を stub
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)

    # require_login を強制無効化
    allow_any_instance_of(ApplicationController)
      .to receive(:require_login).and_return(true)

    # not_authenticated の redirect を無効化
    allow_any_instance_of(ApplicationController)
      .to receive(:not_authenticated).and_return(nil)
  end
end
