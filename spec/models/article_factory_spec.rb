require "rails_helper"

RSpec.describe ArticleFactory do
  describe ".create" do
    it "saves articles to database" do
      article = FactoryBot.build(:article)
      
      ArticleFactory.create([article])
      
      expect(Article.count).to eq(1)
    end
    
    it "doesn't save an article twice" do
      article1 = FactoryBot.build(:article, :url => "example.com/article1")
      article2 = FactoryBot.build(:article, :url => "example.com/article1")
      
      ArticleFactory.create([article1, article2])
      
      expect(Article.count).to eq(1)
    end
  end
end