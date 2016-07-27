desc "This task is called by the Heroku scheduler add-on"
task :send_notification => :environment do
  NotificationsMailer.pending_cards_notification.deliver_now
end
