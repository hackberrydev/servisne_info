require "rails_helper"

RSpec.describe Site021, :vcr do
  before do
    scraper = Site021.new(ActiveSupport::Logger.new("/dev/null"))

    @articles = scraper.scrape
  end

  it "scrapes articles from 021.rs" do
    expect(@articles.count).to eq(20)
  end

  it "scrapes content for articles" do
    article = @articles[4]
    expect(article.title).to eq("Isključenja struje za četvrtak, 24. jun")
    expect(article.url).to eq("https://www.021.rs/story/Novi-Sad/Servisne-informacije/277402/Iskljucenja-struje-za-cetvrtak-24-jun.html")
    expect(article.content).to match(/Delovi Novog Sada i Rakovca u četvrtak, 24. juna neće imati struje./)
    expect(article.content).to match(/Železnička 6-30, 3-9, Vase Stajića 22-22c, firme: Zoil Vojvodina, banke, od 8:30 do 10:30 časova/)
  end

  it "doesn't include scrape content that's not from Novi Sad" do
    article = @articles[4]
    expect(article.content).not_to match(/Manastirska, Stošin do, Stari Rakovac, od 9 do 12 časova/)
  end
end
