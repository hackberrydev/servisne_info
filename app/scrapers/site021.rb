class Site021
  def initialize(logger)
    @logger = logger
  end
  
  def scrape
    @logger.info "Scrape site - 021.rs"
    page = mechanize.get("https://www.021.rs/Novi-Sad/Servisne-informacije/6")
    page.search(".col-md-8 .storyCatList .article_wrapper").map do |article_html|
      build_article(article_html)
    end
  end
  
  private
  
  def build_article(article_html)
    article = Article.new(
      :title => article_html.at(".article_title a span").text.strip,
      :url => article_html.at(".article_title a").attr("href").strip
    )
    
    page = mechanize.get(article.url)
    intro = page.at(".intro").text.strip
    body = page.at(".bodyText > div").text.strip
    article.content = intro + body
    
    @logger.info "Scrape article - #{article.url}"
    
    article
  end
  
  def mechanize
    @mechanize ||= Mechanize.new do |mechanize|
      mechanize.max_history = 0
    end
  end
end 