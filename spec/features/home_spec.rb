require 'rails_helper'

feature 'review card on home page' do
  context 'registred user' do
    before(:each) do
      @user = create(:user, email: 'qqq@www')
      login('qqq@www', 'password')
       @user.decks.create!(title: 'kkk', description: 'ggg')
    end

    let!(:card) { create(:card_for_review, deck_id: @user.decks.first.id) }

    scenario 'card to review exists' do
      visit root_path
      expect(page).to have_css("img[src*='#{card.image_url}']")
      expect(page).to have_content card.translated_text.capitalize
    end

    scenario 'card image on review' do
      visit root_path
      expect(page).to have_css("img[src*='#{card.image_url}']")
    end

    scenario 'no cards to review' do
      card.update(review_date: Time.now + 3.days)
      visit root_path
      expect(page).to have_content I18n.t('views.home.no_cards')
    end

    scenario 'user answered correctly' do
      visit root_path
      fill_in 'trainer[answer]', with: card.original_text
      click_button I18n.t('views.home.answer')
      expect(page).to have_content I18n.t('controllers.trainer.correct')
    end

    scenario 'user answered incorrectly' do
      visit root_path
      fill_in 'trainer[answer]', with: 'wrong_answer'
      click_button I18n.t('views.home.answer')
      expect(page).to have_content I18n.t('controllers.trainer.wrong')
    end
  end
end
