def login(email, password)
  visit root_path
  click_link I18n.t('views.layout.login')
  fill_in 'session[email]', with: email
  fill_in 'session[password]', with: password
  click_button I18n.t('views.session.sign_in')
end