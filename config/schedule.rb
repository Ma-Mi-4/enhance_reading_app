set :output, "/rails/log/cron.log"
set :environment, ENV['RAILS_ENV'] || 'development'

env :PATH, "/usr/local/bin:/usr/bin:/bin:/usr/local/bundle/bin"
env :BUNDLE_GEMFILE, "/rails/Gemfile"

every 1.minute do
  runner "NotificationService.send_scheduled_notifications", environment: 'development'
end
