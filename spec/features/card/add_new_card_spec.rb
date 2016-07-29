require 'rails_helper'

feature 'add new card' do
  before(:each) do
    @user = create(:user, email: 'qqq@www')
    login('qqq@www', 'password')
    @user.decks.create!(title: 'kkk', description: 'ggg')
  end

  scenario 'all fields are filled' do

    visit new_deck_card_path(@user.decks.first.id)
    fill_in 'card[original_text]', with: 'original text'
    fill_in 'card[translated_text]', with: 'translated text'
    click_button t('cards.new.save_card')
    expect(page).to have_content t('cards.create.create')
    expect(page).to have_content 'original text translated text'
  end

  scenario 'the translated text field is not filled' do
    visit new_deck_card_path(@user.decks.first.id)
    fill_in 'card[original_text]', with: 'original text'
    click_button t('cards.new.save_card')
    expect(page).to have_content t('errors.messages.blank')
  end

  scenario 'upload image' do
    visit new_deck_card_path(@user.decks.first.id)
    fill_in 'card[original_text]', with: 'original text'
    fill_in 'card[translated_text]', with: 'translated text'
    attach_file('card[image]', "#{Rails.root}/spec/support/files/card.png")
    click_button t('cards.new.save_card')
    expect(page).to have_content t('cards.create.create')
    expect(page).to have_css("img[src*='#{Card.first.image_url(:thumb)}']")
  end

  scenario 'upload image from remote url' do
    visit new_deck_card_path(@user.decks.first.id)
    fill_in 'card[original_text]', with: 'original text'
    fill_in 'card[translated_text]', with: 'translated text'
    fill_in 'card[remote_image_url]', with: 'http://s.bash.im/logo.gif'
    click_button t('cards.new.save_card')
    expect(page).to have_content t('cards.create.create')
    expect(page).to have_css("img[src*='#{Card.first.image_url(:thumb)}']")
  end

  scenario 'upload not image file' do
    visit new_deck_card_path(@user.decks.first.id)
    fill_in 'card[original_text]', with: 'original text'
    fill_in 'card[translated_text]', with: 'translated text'
    attach_file('card[image]', "#{Rails.root}/spec/support/files/card.pdf")
    click_button t('cards.new.save_card')
    expect(page).to have_content 'You are not allowed to upload "pdf" files'
  end
end 
