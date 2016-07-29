require 'rails_helper'

feature 'new user regitration' do
  scenario 'registration successful' do
    visit new_registration_path
    fill_in 'user[name]', with: 'zaza'
    fill_in 'user[email]', with: 'aaa@bbb'
    fill_in 'user[password]', with: '12345'
    fill_in 'user[password_confirmation]', with: '12345'
    click_button t('registrations.new.save_user')
    expect(page).to have_content t('registrations.create.create')
    expect(page).to have_content t('layouts.application.logout')
  end

  scenario 'registration failed' do
    visit new_registration_path
    fill_in 'user[name]', with: 'zaza'
    fill_in 'user[email]', with: 'aaa@bbb'
    fill_in 'user[password]', with: '12345'
    fill_in 'user[password_confirmation]', with: '54321'
    click_button t('registrations.new.save_user')
    expect(page).to have_content "Password confirmation doesn't match"
    expect(page).to have_content t('layouts.application.register')
  end
end
