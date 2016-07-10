require 'rails_helper'

feature 'add new card' do
  scenario 'good' do #title!!!
    visit new_card_path
    fill_in 'card[original_text]', with: 'original text'
    fill_in 'card[translated_text]', with: 'translated text'
    click_button I18n.t('views.card.save_card')
    expect(page).to have_content I18n.t('controllers.card.create')
    expect(page).to have_content 'original text translated text'
  end

    scenario 'false' do #title!!!
    visit new_card_path
    click_button I18n.t('views.card.save_card')
    expect(page).to have_content "Original Translated text can't be blank"
  end
end 