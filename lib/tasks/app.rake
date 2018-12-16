namespace :app do
  desc "Scrape new articles"
  task :scrape_articles => :environment do
    articles = Site021.new.scrape
    
    ArticleFactory.create(articles)
  end
end