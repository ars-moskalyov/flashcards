require 'rails_helper'

describe 'pending_cards_notification' do
  let!(:card) { create(:card) }
  let(:mail) { NotificationsMailer.pending_cards_notification(card.user) }

  it 'renders the subject' do
    expect(mail.subject).to eq(I18n.t('mailers.notifications.subject'))
  end

  it 'renders the receiver email' do
    expect(mail.to).to eq([card.user.email])
  end

  it 'renders the sender email' do
    expect(mail.from).to eq(['www@flashcards.com.de'])
  end
end
