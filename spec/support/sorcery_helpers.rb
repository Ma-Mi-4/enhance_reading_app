module SorceryHelpers
  def login_user(user)
    allow_any_instance_of(QuestionsController)
      .to receive(:current_user)
      .and_return(user)
  end

  def logout_user
    allow_any_instance_of(QuestionsController)
      .to receive(:current_user)
      .and_return(nil)
  end
end

RSpec.configure do |config|
  config.include SorceryHelpers, type: :request
end
