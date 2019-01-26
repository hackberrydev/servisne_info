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
end