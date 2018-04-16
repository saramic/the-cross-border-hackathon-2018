Capybara.javascript_driver = :selenium_chrome

# requires
#   brew install chromedriver
Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    clear_local_storage: true,
    clear_session_storage: true,
    desired_capabilities: {
      chromeOptions: {
        args: %w( window-size=1024,768 ),
        prefs: {
        }
      }
    }
  )
end

Capybara.configure do |config|
  config.run_server = true
end
