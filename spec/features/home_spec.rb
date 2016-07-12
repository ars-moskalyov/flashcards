require 'rails_helper'

feature 'review card on home page' do
  scenario 'card to review exists' do
    card = create(:card_for_review)
    visit root_path
    expect(page).to have_content card.translated_text.capitalize
  end

  scenario 'no cards to review' do
    visit root_path
    expect(page).to have_content I18n.t('views.home.no_cards')
  end

  scenario 'user answered correctly' do
    card = create(:card_for_review)
    visit root_path
    fill_in 'trainer[answer]', with: card.original_text
    click_button I18n.t('views.home.answer')
    expect(page).to have_content I18n.t('controllers.trainer.correct')
  end

  scenario 'user answered incorrectly' do
    card = create(:card_for_review)
    visit root_path
    fill_in 'trainer[answer]', with: 'wrong_answer'
    click_button I18n.t('views.home.answer')
    expect(page).to have_content I18n.t('controllers.trainer.wrong')
  end
end
