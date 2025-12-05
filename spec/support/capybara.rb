require "capybara/rspec"
require "capybara/cuprite"

Capybara.server = :puma, { Silent: true }

Capybara.default_driver = :cuprite
Capybara.javascript_driver = :cuprite

Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(
    app,
    window_size: [1200, 800],
    browser_options: {},
    inspector: true,
    headless: true
  )
end
