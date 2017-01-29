#!/usr/bin/env ruby
require 'io/console'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, js_errors: false)
end

Capybara.default_driver = :poltergeist

email = ENV['LEBENSKRIPT_USER']
password = ENV['LEBENSKRIPT_PASSWORD']

browser = Capybara.current_session
url = 'https://lebensmittel.us/users/sign_in'
browser.visit url

browser.fill_in 'user_email', with: email
browser.fill_in 'user_password', with: password
browser.click_on 'Log in'

browser.click_on ARGV.shift
browser.fill_in 'item_name', with: ARGV.shift
browser.click_on 'Add'

logout = 'https://lebensmittel.us/users/sign_out'
browser.visit logout
