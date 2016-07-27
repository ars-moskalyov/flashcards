class NotificationsMailer < ActionMailer::Base
  default from: 'www@flashcards.com.de'

  def pending_cards_notification(user)
    @name = user.name
    I18n.with_locale(user.locale) do
      mail(to: user.email, subject: t('mailers.notifications.subject'))
    end
  end
end
