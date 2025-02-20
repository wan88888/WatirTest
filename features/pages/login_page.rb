class LoginPage
  include PageObject

  page_url 'https://the-internet.herokuapp.com/login'

  text_field(:username, id: 'username')
  text_field(:password, id: 'password')
  button(:login_button, css: 'button[type="submit"]')
  div(:success_message, id: 'flash')

  def success_message_present?
    success_message_element.present? &&
      success_message_element.text.include?('You logged into a secure area!')
  end
end