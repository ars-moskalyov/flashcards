desc "This task is called by the Heroku scheduler add-on"
  task :send_notification => :environment do
    User.send_notification
  end
