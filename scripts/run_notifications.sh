export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/bundle/bin
export BUNDLE_GEMFILE=/rails/Gemfile
cd /rails
bundle exec rails runner "NotificationService.send_scheduled_notifications"
