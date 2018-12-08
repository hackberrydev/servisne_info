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
  end
end
