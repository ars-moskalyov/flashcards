require 'rails_helper'

feature 'default deck' do
  before(:each) do
    @user = create(:user, email: 'qqq@www')
    login('qqq@www', 'password')
    @user.decks.create!(title: 'fff', description: 'zzz')
    @user.decks.create!(title: 'kkk', description: 'ggg')
  end

  scenario 'is set' do
    visit decks_path
    page.first('a', text: I18n.t('views.deck.set_default')).click
    expect(page).to have_content I18n.t('views.deck.default')
  end

  scenario 'no set' do
    visit decks_path
    expect(page).to have_content I18n.t('views.deck.set_default')
  end
end
