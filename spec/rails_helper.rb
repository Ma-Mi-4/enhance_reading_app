require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
require 'database_cleaner-active_record'

Capybara.server = :puma, { Silent: true }

Dir[Rails.root.join("spec/support/**/*.rb")].sort.each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include Rails.application.routes.url_helpers, type: :request
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each, type: :system) do |example|
    example.run
  end

  config.filter_run_excluding type: :system if ENV["CI"]
end

require "capybara/rspec"
require "capybara/cuprite"

Capybara.server = :puma, { Silent: true }

# ★ Docker必須設定 ★
Capybara.server_host = "0.0.0.0"
Capybara.server_port = 3001
Capybara.app_host = "http://localhost:3001"

browser_path = ENV["CHROME_PATH"] || "/usr/bin/chromium"

Capybara.register_driver :cuprite do |app|
  Capybara::Cuprite::Driver.new(
    app,
    browser_path: browser_path,
    window_size: [1400, 900],
    process_timeout: 120, # ← ここが効く
    timeout: 60,
    browser_options: {
      "headless" => nil,
      "no-sandbox" => nil,
      "disable-dev-shm-usage" => nil,
      "disable-gpu" => nil
    }
  )
end

Capybara.default_driver = :cuprite
Capybara.javascript_driver = :cuprite
