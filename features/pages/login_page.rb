require 'page-object'

class LoginPage
  include PageObject

  page_url 'http://the-internet.herokuapp.com/login'
  
  text_field(:username, id: 'username')
  text_field(:password, id: 'password')
  button(:login_button, css: 'button[type="submit"]')
  div(:flash_message, id: 'flash')

  def initialize(browser)
    super(browser)
  end

  def login_with(username, password)
    self.username = username
    self.password = password
    login_button
  end

  def success_message_present?
    flash_message_element.visible? &&
    flash_message_element.text.include?('You logged into a secure area!')
  end
end