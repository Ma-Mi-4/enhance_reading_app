if Rails.env.production?
  Rails.application.config.session_store :cookie_store,
    key: "_enhance_session",
    same_site: :none,
    secure: true
end
