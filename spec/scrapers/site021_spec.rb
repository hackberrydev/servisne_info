require 'rails_helper'

RSpec.describe Site021 do
  it "scrapes articles from 021.rs" do
    scraper = Site021.new

    articles = scraper.scrape

    expect(articles.count).to eq(20)
    
    article = articles.third
    expect(article.title).to eq("Limani III i IV danas bez tople vode, Spens, NIS i Merkator bez grejanja")
    expect(article.url).to eq("https://www.021.rs/story/Novi-Sad/Servisne-informacije/203381/Limani-III-i-IV-danas-bez-tople-vode-Spens-NIS-i-Merkator-bez-grejanja.html")
  end
end