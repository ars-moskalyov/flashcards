require 'rails_helper'

feature 'registred user' do
  let!(:user) { create(:user, email: 'qqq@www') }

  context 'login' do
    scenario 'with correct login/password' do
      visit root_path
      click_link t('layouts.application.login')
      fill_in 'session[email]', with: 'qqq@www'
      fill_in 'session[password]', with: 'password'
      click_button t('sessions.new.sign_in')
      expect(page).to have_content t('sessions.create.login_s')
    end

    scenario 'with incorrect login/password' do
      visit root_path
      click_link t('layouts.application.login')
      fill_in 'session[email]', with: 'qqq@zzz'
      fill_in 'session[password]', with: 'password'
      click_button t('sessions.new.sign_in')
      expect(page).to have_content t('sessions.create.login_f')
    end
  end

  scenario 'logout' do
    login('qqq@www', 'password')
    visit root_path
    click_link t('layouts.application.logout')
    expect(page).to have_content t('sessions.destroy.logout')
  end
end
