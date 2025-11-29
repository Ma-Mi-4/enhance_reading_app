Rails.application.config.session_store :cookie_store,
  key: '_enhance_reading_app_session',
  domain: '.fly.dev',
  same_site: :none,
  secure: true
