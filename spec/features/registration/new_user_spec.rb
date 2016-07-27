require 'rails_helper'

feature 'new user regitration' do
  scenario 'registration successful' do
    visit new_registration_path
    fill_in 'registration[name]', with: 'zaza'
    fill_in 'registration[email]', with: 'aaa@bbb'
    fill_in 'registration[password]', with: '12345'
    fill_in 'registration[password_confirmation]', with: '12345'
    click_button I18n.t('views.registration.save_user')
    expect(page).to have_content I18n.t('controllers.registration.created')
    expect(page).to have_content I18n.t('views.layout.logout')
  end

  scenario 'registration failed' do
    visit new_registration_path
    fill_in 'registration[name]', with: 'zaza'
    fill_in 'registration[email]', with: 'aaa@bbb'
    fill_in 'registration[password]', with: '12345'
    fill_in 'registration[password_confirmation]', with: '54321'
    click_button I18n.t('views.registration.save_user')
    expect(page).to have_content "Password confirmation doesn't match"
    expect(page).to have_content I18n.t('views.layout.register')
  end
end
