class ArticleFactory
  def initialize(logger)
    @logger = logger
  end

  def create(articles)
    filter(articles).each do |article|
      if article_exists?(article)
        @logger.warn "Skip article - #{article.url}"
      else
        @logger.info "Save article - #{article.url}"
        article.save!
        Event.create!(message: "New article - #{article.url}")
      end
    end
  end

  private

  def filter(articles)
    articles.reject do |article|
      article.title.downcase.starts_with?("raspored sahrana")
    end
  end

  def article_exists?(article)
    Article.exists?(url: article.url) || Article.exists?(external_id: article.external_id)
  end
end
