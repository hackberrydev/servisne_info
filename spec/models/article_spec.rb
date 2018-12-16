require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "validations" do
    it "must have url" do
      article = FactoryBot.build(:article, :url => nil)
      
      expect(article.valid?).to be_falsy
      expect(article.errors[:url]).to be_present
    end
    
    it "must have title" do
      article = FactoryBot.build(:article, :title => nil)
      
      expect(article.valid?).to be_falsy
      expect(article.errors[:title]).to be_present
    end
    
     it "must have content" do
      article = FactoryBot.build(:article, :content => nil)
      
      expect(article.valid?).to be_falsy
      expect(article.errors[:content]).to be_present
    end
    
    it "must have unique url" do
      FactoryBot.create(:article, :url => "example.com/article1")
      
      article = FactoryBot.build(:article, :url => "example.com/article1")
      
      expect(article.valid?).to be_falsy
      expect(article.errors[:url]).to be_present
    end
  end
  
  describe ".recent" do
    it "returns last 10 articles" do
      old_article = FactoryBot.create(:article)
      recent_articles = FactoryBot.create_list(:article, 10)
      
      expect(Article.recent).to eq(recent_articles.reverse)
    end
  end
end
