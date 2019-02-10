require "rails_helper"

RSpec.describe ArticleFactory do
  describe "#create" do
    before do
      @factory = ArticleFactory.new(ActiveSupport::Logger.new("/dev/null"))
    end 
    
    it "saves articles to database" do
      article = FactoryBot.build(:article)
      
      @factory.create([article])
      
      expect(Article.count).to eq(1)
    end
    
    it "doesn't save an article twice" do
      article1 = FactoryBot.build(:article, :url => "example.com/article1")
      article2 = FactoryBot.build(:article, :url => "example.com/article1")
      
      @factory.create([article1, article2])
      
      expect(Article.count).to eq(1)
    end
    
    it "creates event" do
      article = FactoryBot.build(:article)
      
      @factory.create([article])
      
      event = Event.last
      
      expect(event.message).to eq("New article - #{article.url}")
    end
  end
end