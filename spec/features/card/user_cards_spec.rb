require 'rails_helper'

feature 'user' do
  before(:each) do
    @user = create(:user, email: 'qqq@www')
    login('qqq@www', 'password')
    create(:card, translated_text: 'authorized user card', user_id: @user.id)
    create(:card, translated_text: 'card of another user')
  end

  scenario 'has access to his cards' do
    visit cards_path
    expect(page).to have_content 'authorized user card'
  end

  scenario 'does not have access to other users cards' do
    visit cards_path
    expect(page).to have_no_content 'card of another user'
  end

  scenario 'can edit his cards' do
    visit cards_path
    click_link I18n.t('views.card.edit')
    fill_in 'card[original_text]', with: 'lorem ipsum'
    click_button I18n.t('views.card.save_card')
    expect(page).to have_content I18n.t('controllers.card.update')
    expect(page).to have_content 'lorem ipsum'
  end
end
