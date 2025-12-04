module SorceryHelpers
  # Sorcery の仕組みを利用して擬似的にログインする
  def login_user(user)
    # テスト用のダミーエンドポイントを叩いて auto_login を動かす
    post test_login_path, params: { user_id: user.id }
  end

  def logout_user
    delete logout_path
  end
end

RSpec.configure do |config|
  config.include SorceryHelpers, type: :request
end
