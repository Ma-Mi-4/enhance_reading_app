require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
require 'capybara/rspec'
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

  config.around(:each) do |example|
    DatabaseCleaner.cleaning { example.run }
  end

  config.before(:each, type: :request) do
    user = create(:user)

    # Sorcery 全体を stub
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)

    # require_login を何もしない
    allow_any_instance_of(ApplicationController)
      .to receive(:require_login).and_return(true)

    # not_authenticated も無効化
    allow_any_instance_of(ApplicationController)
      .to receive(:not_authenticated).and_return(false)
  end
end

Capybara.default_driver = :rack_test
Capybara.javascript_driver = :rack_test
Capybara.current_driver = :rack_test
