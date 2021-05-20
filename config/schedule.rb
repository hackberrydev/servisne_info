# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

env :PATH, ENV["PATH"]
set :output, "log/cron.log"

every 1.hour do
  rake "app:scrape_articles"
end

every "30 * * * *" do
  rake "app:send_pending_articles"
end

every "15 6 * * *" do
  rake "app:send_daily_report"
end

every "0 6 * * *" do
  rake "app:backup_users"
end

# every 10.minutes do
#   rake "app:scrape_url"
# end
