module CurrentUserStub
  def current_user
    @current_user ||= User.first || FactoryBot.create(:user)
  end
end

RSpec.configure do |config|
end
