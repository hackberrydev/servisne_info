class ArticleFactory
  def self.create(articles)
    articles.each do |article|
      article.save!
    end
  end
end