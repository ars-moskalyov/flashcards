require 'rails_helper'

feature 'add new card' do
  before(:each) do
    @user = create(:user, email: 'qqq@www')
    login('qqq@www', 'password')
  end
  
  scenario 'all fields are filled' do
    visit new_card_path
    fill_in 'card[original_text]', with: 'original text'
    fill_in 'card[translated_text]', with: 'translated text'
    click_button I18n.t('views.card.save_card')
    expect(page).to have_content I18n.t('controllers.card.create')
    expect(page).to have_content 'original text translated text'
  end

    scenario 'the translated text field is not filled' do
    visit new_card_path
    fill_in 'card[original_text]', with: 'original text'
    click_button I18n.t('views.card.save_card')
    expect(page).to have_content I18n.t('views.card.new_card')
    expect(page).to have_content I18n.t('errors.messages.blank')
  end
end 
