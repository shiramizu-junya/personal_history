Rspe.configure do |config|
  config.before(:each, type: :system) do
    # driven_by using: :rack_test
    # driven_by :selenium, using: :chrome
    driven_by :selenium, using: :headless_chrome
  end
end
