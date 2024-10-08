class Site021
  def initialize(logger)
    @logger = logger
  end

  def scrape
    @logger.info "Scrape site - 021.rs"
    page = mechanize.get("https://www.021.rs/Novi-Sad/Servisne-informacije/6")
    page.search("main article").map do |article_html|
      build_article(article_html)
    end
  end

  private

  def build_article(article_html)
    article = Article.new(
      title: article_html.at(".articleTitle a").text.strip,
      url: article_html.at(".articleTitle a").attr("href").strip
    )

    page = mechanize.get(article.url)
    intro = page.at(".storyLead").text.strip
    paragraphs = page.search(".storyBody .innerBody div")
      .map { |p| p.text.strip }
      .compact_blank
    body = remove_news_for_vilages(paragraphs).join
    article.content = intro + body

    @logger.info "Scrape article - #{article.url}"

    article
  end

  def remove_news_for_vilages(news)
    return news unless news.first == "NOVI SAD"

    news.drop(1).take_while { |n| n.upcase != n }
  end

  def mechanize
    @mechanize ||= Mechanize.new do |mechanize|
      mechanize.max_history = 0
    end
  end
end
