Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://enhance-reading-app-morning-sound-6129.fly.dev', 'http://localhost:3002'
    resource '*',
      headers: :any,
      methods: [:get, :post, :patch, :put, :delete, :options, :head],
      credentials: true
  end
end
