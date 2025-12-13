module CurrentUserStub
  def current_user
    @current_user ||= User.first || FactoryBot.create(:user)
  end
end

RSpec.configure do |config|
  config.before(:each, type: :request) do
    ApplicationController.prepend(CurrentUserStub)
  end
end
