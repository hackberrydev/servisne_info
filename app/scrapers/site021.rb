class Site021
  def scrape
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
    body = page.at(".bodyText").text.strip
    article.content = intro + body
    
    article
  end
  
  def mechanize
    @mechanize ||= Mechanize.new do |mechanize|
      mechanize.max_history = 0
    end
  end
end 