class Site021
  def initialize(logger)
    @logger = logger
  end

  def scrape
    @logger.info "Scrape site - 021.rs"
    page = mechanize.get("https://www.021.rs/Novi-Sad/Servisne-informacije/6")

    page
      .search("main article")
      .flat_map { |article_html| build_articles(article_html) }
  end

  private

  def build_articles(article_html)
    url = article_html.at(".articleTitle a").attr("href").strip
    title = article_html.at(".articleTitle a").text.strip

    page = mechanize.get(url)
    intro = page.at(".storyLead").text.strip

    paragraphs = page
      .search(".storyBody .innerBody div")
      .map { |p| p.text.strip }
      .compact_blank

    articles = paragraphs_per_town(paragraphs).map do |town, paragraphs|
      Article.new(
        content: intro + paragraphs.join,
        title: title,
        town: town,
        url: url
      )
    end

    @logger.info "Scrape article - #{url}"

    articles
  end

  def paragraphs_per_town(paragraphs)
    unless paragraphs.first == "NOVI SAD"
      return {"novi sad" => paragraphs.drop(1)}
    end

    title = "novi sad"

    paragraphs.each_with_object({"novi sad" => []}) do |paragraph, per_town|
      if paragraph.upcase == paragraph
        title = paragraph.downcase
        per_town[title] = []
      else
        per_town[title] << paragraph
      end
    end
  end

  def mechanize
    @mechanize ||= Mechanize.new do |mechanize|
      mechanize.max_history = 0
    end
  end
end
