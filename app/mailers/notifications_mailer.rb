class NotificationsMailer < ActionMailer::Base
  default from: 'www@flashcards.com.de'

  def pending_cards_notification
    users = User.joins(:cards).where('cards.review_date <= ?', Time.current).pluck(:email, :name, :locale).uniq!
    users.each do |user|
      @name = user[1]
      I18n.with_locale(user[2]) do
        mail(to: user[0], subject: t('mailers.notifications.subject'))
      end
    end
  end
end
