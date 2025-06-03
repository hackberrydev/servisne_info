require "rails_helper"

RSpec.describe ArticleFactory do
  describe "#create" do
    before do
      @factory = ArticleFactory.new(ActiveSupport::Logger.new(File::NULL))
    end

    it "saves articles to database" do
      article = FactoryBot.build(:article)

      @factory.create([article])

      expect(Article.count).to eq(1)
    end

    it "creates event" do
      article = FactoryBot.build(:article)

      @factory.create([article])

      event = Event.last

      expect(event.message).to eq(%(New article for "novi sad" - #{article.url}))
    end

    it "doesn't save an article twice" do
      article1 = FactoryBot.build(:article, url: "example.com/article1")
      article2 = FactoryBot.build(:article, url: "example.com/article1")

      @factory.create([article1, article2])

      expect(Article.count).to eq(1)
    end

    it "doesn't save articles about 'Raspored sahrana'" do
      article = FactoryBot.build(:article, title: "Raspored sahrana za ponedeljak")

      @factory.create([article])

      expect { @factory.create([article]) }.not_to change { Article.count }
    end

    it "doesn't create an article with a duplicate external_id" do
      FactoryBot.create(:article, external_id: "424242")

      article = FactoryBot.build(:article, external_id: "424242")

      expect { @factory.create([article]) }.not_to change { Article.count }
    end
  end
end
