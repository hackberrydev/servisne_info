require "rails_helper"

RSpec.describe ArticleFactory do
  describe ".create" do
    it "saves articles to database" do
      article = FactoryBot.build(:article)
      
      ArticleFactory.create([article])
      
      expect(Article.count).to eq(1)
    end
  end
end