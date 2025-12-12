if Rails.env.test?
  class TestLoginMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      # Sorcery の current_user を強制的に差し替える
      request = ActionDispatch::Request.new(env)
      user_id = request.session[:test_user_id]

      if user_id
        user = User.find_by(id: user_id)
        env['rack.session'][:user_id] = user&.id
      end

      @app.call(env)
    end
  end

  Rails.application.config.middleware.use TestLoginMiddleware
end
