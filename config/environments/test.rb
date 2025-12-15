require "active_support/core_ext/integer/time"

Rails.application.configure do
  # application.rb より優先される
  # config.enable_reloading = false

  # CI では eager_load true でOK、それ以外は false
  config.eager_load = ENV["CI"].present?

  # public ファイル配信
  config.public_file_server.enabled = true
  config.public_file_server.headers = {
    "Cache-Control" => "public, max-age=#{1.hour.to_i}"
  }

  # エラーはテストで「例外としてそのまま出す」のがデフォ
  # こうすることで 403 ラップじゃなく、本当の例外原因が見える
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.cache_store = :null_store

  # ここが今 :rescuable になっているはずなので **false に戻す**
  config.action_dispatch.show_exceptions = false

  # CSRF は test では無効（POST で 422 にならないように）
  config.action_controller.allow_forgery_protection = false

  # ActiveStorage
  config.active_storage.service = :test

  config.action_mailer.perform_caching = false
  config.action_mailer.delivery_method = :test

  config.active_support.deprecation = :stderr
  config.active_support.disallowed_deprecation = :raise
  config.active_support.disallowed_deprecation_warnings = []

  # callback のミスはエラーにする
  config.action_controller.raise_on_missing_callback_actions = true

  # メールの URL 用（既存と合わせてOK）
  config.action_mailer.default_url_options = {
    host: ENV["APP_HOST"] || "localhost:3000"
  }

  config.action_controller.allow_forgery_protection = false
  config.action_controller.forgery_protection_origin_check = false
  config.action_dispatch.show_exceptions = false

  Rails.application.config.session_store :cookie_store,
  key: "_enhance_session",
  same_site: :lax,
  secure: false
end
