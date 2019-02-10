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
end