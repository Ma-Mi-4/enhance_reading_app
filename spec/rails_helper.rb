require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_paths = [
    Rails.root.join('spec/fixtures')
  ]

  config.use_transactional_fixtures = false  # ★ 重要：DatabaseCleaner を使うので無効化

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  # FactoryBot
  config.include FactoryBot::Syntax::Methods

  # --------------------------------------------------------------------
  # System test drivers
  # --------------------------------------------------------------------
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium_chrome_headless
  end

  # --------------------------------------------------------------------
  # DatabaseCleaner 設定（system test の email 重複問題を解決）
  # --------------------------------------------------------------------
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  # System テスト（feature/JS）ではトランザクションが効かない
  config.before(:each, type: :system) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

# --------------------------------------------------------------------
# Shoulda Matchers
# --------------------------------------------------------------------
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

# Support を後から読み込む（これ重要）
Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }
