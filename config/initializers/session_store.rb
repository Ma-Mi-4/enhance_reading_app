Rails.application.config.session_store :cookie_store,
  key: "_enhance_reading_app_session",
  secure: Rails.env.production?,
  same_site: :lax 