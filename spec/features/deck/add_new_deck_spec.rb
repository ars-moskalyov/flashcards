require 'rails_helper'

feature 'add new deck' do
  before(:each) do
    @user = create(:user, email: 'qqq@www')
    login('qqq@www', 'password')
  end

  scenario 'all fields are filled' do
    visit new_deck_path
    fill_in 'deck[title]', with: 'deck title'
    fill_in 'deck[description]', with: 'deck description'
    click_button t('decks.form.save_deck')
    expect(page).to have_content t('decks.create.create')
  end

  scenario 'title field is not filled' do
    visit new_deck_path
    fill_in 'deck[title]', with: 'deck title'
    click_button t('decks.form.save_deck')
    expect(page).to have_content t('errors.messages.blank')
  end
end 
