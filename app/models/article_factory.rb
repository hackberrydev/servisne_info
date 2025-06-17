class ArticleFactory
  def initialize(logger)
    @logger = logger
  end

  def create(articles)
    filter(articles).each do |article|
      if Article.exists?(url: article.url, town: article.town)
        @logger.warn "Skip article (existing url) - #{article.url}"
      elsif Article.exists?(external_id: article.external_id, town: article.town)
        @logger.warn "Skip article (existing external_id) - #{article.url}"
      else
        @logger.info "Save article - #{article.url}"
        article.save!
        Event.create!(message: %(New article for "#{article.town}" - #{article.url}))
      end
    end
  end

  private

  def filter(articles)
    articles.reject do |article|
      article.title.downcase.starts_with?("raspored sahrana")
    end
  end
end
