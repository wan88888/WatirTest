require_relative '../pages/login_page'

Given('I am on the login page') do
  @page = LoginPage.new(@browser)
  @page.goto
end

When('I enter username {string}') do |username|
  @page.username = username
end

When('I enter password {string}') do |password|
  @page.password = password
end

When('I click the login button') do
  @page.login_button
end

Then('I should see a success message') do
  expect(@page.success_message_present?).to be true
end