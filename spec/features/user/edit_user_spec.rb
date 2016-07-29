require 'rails_helper'

feature 'user can edit profile' do
  before(:each) do
    @user = create(:user, email: 'qqq@www')
    login('qqq@www', 'password')
  end

  scenario 'user can change email' do
    visit edit_users_path
    fill_in 'user[email]', with: 'aaa@bbb'
    click_button t('users.edit.save')
    expect(page).to have_content t('users.update.updated')
  end

  scenario 'user can change password' do
    visit edit_users_path
    fill_in 'user[password]', with: '12345'
    fill_in 'user[password_confirmation]', with: '12345'
    click_button t('users.edit.save')
    expect(page).to have_content t('users.update.updated')
  end
end
