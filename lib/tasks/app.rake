namespace :app do
  desc "Scrape new articles"
  task :scrape_articles => :environment do
    logger = ActiveSupport::Logger.new(STDOUT)
    scraper = Site021.new(logger)
    articles = scraper.scrape

    factory = ArticleFactory.new(logger)
    factory.create(articles)
  end

  desc "Send pending articles"
  task :send_pending_articles => :environment do
    SendArticles.new.call
  end

  desc "Send daily report"
  task :send_daily_report => :environment do
    Rails.application.credentials.admins.each do |email|
      AdminMailer.daily_report(email, Event.recent).deliver_now
    end
  end

  desc "Import users"
  task :import_users => :environment do
    users = eval(File.open(File.expand_path("users.rb")).read)

    users.each do |user_attributes|
      email = user_attributes[:email]
      streets = user_attributes[:streets].join(", ")

      user = User.new
      user.email = email
      user.streets = streets
      user.password = Devise.friendly_token

      if user.save
        puts "User saved #{email}"
      else
        puts "User invalid #{email} - #{user.errors.messages}"
      end
    end
  end
end
