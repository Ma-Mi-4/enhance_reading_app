Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://frontend-autumn-morning-199.fly.dev'

    resource '*',
      headers: :any,
      methods: [:get, :post, :patch, :put, :delete, :options, :head],
      credentials: true
  end
end
