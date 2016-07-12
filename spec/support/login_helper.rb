def login(email, password)
  visit root_path
  click_link I18n.t('views.layout.login')
  fill_in 'user_session[email]', with: 'qqq@www'
  fill_in 'user_session[password]', with: 'password'
  click_button 'Save User session'
end