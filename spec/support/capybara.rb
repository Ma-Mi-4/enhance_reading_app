require "capybara/rspec"
require "capybara/cuprite"

Capybara.register_driver :cuprite do |app|
  Capybara::Cuprite::Driver.new(
    app,
    browser_path: ENV.fetch("CHROME_PATH", "/usr/bin/chromium"),
    window_size: [1400, 1400],
    process_timeout: 120,
    timeout: 30,
    browser_options: {
      "no-sandbox" => nil,
      "disable-dev-shm-usage" => nil,
      "disable-gpu" => nil,
      "single-process" => nil
    }
  )
end

Capybara.default_max_wait_time = 5

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :cuprite
  end
end
