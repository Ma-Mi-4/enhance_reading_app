module RequestLoginHelper
  def login(user)
    post "/test_login", params: { user_id: user.id }
  end
end
