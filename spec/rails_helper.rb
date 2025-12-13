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
  config.include RequestLoginHelper, type: :request

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning { example.run }
  end

  config.before(:each, type: :request) do
    ApplicationController.prepend(CurrentUserStub)
  end
end

require "capybara/rspec"
require "capybara/cuprite"

Capybara.register_driver :cuprite do |app|
  Capybara::Cuprite::Driver.new(
    app,
    browser_path: "/usr/bin/chromium",
    window_size: [1400, 900],
    process_timeout: 120,
    timeout: 30,
    browser_options: {
      "headless" => nil,
      "no-sandbox" => nil,
      "disable-dev-shm-usage" => nil,
      "disable-gpu" => nil,
      "disable-software-rasterizer" => nil,
      "disable-features" => "site-per-process",
      "remote-debugging-port" => "0"
    }
  )
end

Capybara.default_driver = :cuprite
Capybara.javascript_driver = :cuprite

RSpec.configure do |config|
  config.before(:each, type: :system) do
    Capybara.current_driver = :cuprite
  end

  config.after(:each, type: :system) do
    Capybara.use_default_driver
  end
end
