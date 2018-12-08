require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "validations" do
    it "must have url" do
      article = FactoryBot.build(:article, :url => nil)
      
      expect(article.valid?).to be_falsy
      expect(article.errors[:url]).to be_present
    end
  end
end
