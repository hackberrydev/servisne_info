class ArticleFactory
  def self.create(articles)
    articles.each do |article|
      article.save! unless Article.exists?(:url => article.url)
    end
  end
end