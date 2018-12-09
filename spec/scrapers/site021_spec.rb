require 'rails_helper'

RSpec.describe Site021, :vcr do
  it "scrapes articles from 021.rs" do
    scraper = Site021.new

    articles = scraper.scrape

    expect(articles.count).to eq(20)
    
    article = articles.third
    expect(article.title).to eq("Limani III i IV danas bez tople vode, Spens, NIS i Merkator bez grejanja")
    expect(article.url).to eq("https://www.021.rs/story/Novi-Sad/Servisne-informacije/203381/Limani-III-i-IV-danas-bez-tople-vode-Spens-NIS-i-Merkator-bez-grejanja.html")
    expect(article.content).to match(/Limani III i IV u subotu 8. decembra biće bez tople vode./)
    expect(article.content).to match(/Od 11 časova bez grejanja su Spens, zgrada NIS-a i Merkator./)
  end
end