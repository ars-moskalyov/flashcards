every 1.day, at: '10:00 am' do
  runner 'NotificationsMailer.pending_cards_notification.deliver_now'
end
