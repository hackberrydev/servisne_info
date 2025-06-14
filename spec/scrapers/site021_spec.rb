require "rails_helper"

RSpec.describe Site021, vcr: {cassette_name: "Site021/scrapes_articles_from_021_rs"} do
  let(:scraper) { Site021.new(ActiveSupport::Logger.new(File::NULL)) }
  let(:articles) { scraper.scrape }

  it "scrapes articles from 021.rs" do
    expect(articles.count).to eq(36)
  end

  it "scrapes content for articles" do
    article = articles[4]
    expect(article.title).to eq("Isključenja struje za četvrtak, 24. jun")
    expect(article.url).to eq("https://www.021.rs/story/Novi-Sad/Servisne-informacije/277402/Iskljucenja-struje-za-cetvrtak-24-jun.html")
    expect(article.content).to match(/Delovi Novog Sada i Rakovca u četvrtak, 24. juna neće imati struje./)
    expect(article.content).to match(/Železnička 6-30, 3-9, Vase Stajića 22-22c, firme: Zoil Vojvodina, banke, od 8:30 do 10:30 časova/)
    expect(article.town).to eq("novi sad")
  end

  it "scrapes articles for towns other than Novi Sad" do
    article = articles[5]
    expect(article.town).to match("rakovac")
    expect(article.content).to match(/Manastirska, Stošin do, Stari Rakovac, od 9 do 12 časova/)
  end

  it "doesn't scrape articles if articles have already been scrapped", vcr: {allow_playback_repeats: true} do
    articles.map(&:save!)

    expect(scraper.scrape).to be_empty
  end

  it "scrapes articles for different towns when they are mentioned only in title", vcr: {cassette_name: "Site021/different_towns"} do
    no_gas_articles = articles.slice(16..18)

    expect(no_gas_articles.map(&:town)).to match_array(["kać", "budisava", "kovilj"])
    expect(no_gas_articles.map(&:url).uniq).to match_array(["https://www.021.rs/story/Novi-Sad/Servisne-informacije/411959/Da-znate-na-vreme-Kac-Budisava-i-Kovilj-od-7-do-11-jula-bez-gasa.html"])
  end
end
