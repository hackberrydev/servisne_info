# frozen_string_literal: true

require "rails_helper"

RSpec.describe Article, :type => :model do
  describe "validations" do
    it "must have url" do
      article = FactoryBot.build(:article, :url => nil)

      expect(article).not_to be_valid
      expect(article.errors[:url]).to be_present
    end

    it "must have title" do
      article = FactoryBot.build(:article, :title => nil)

      expect(article).not_to be_valid
      expect(article.errors[:title]).to be_present
    end

     it "must have content" do
      article = FactoryBot.build(:article, :content => nil)

      expect(article).not_to be_valid
      expect(article.errors[:content]).to be_present
    end

    it "must have unique url" do
      FactoryBot.create(:article, :url => "example.com/article1")

      article = FactoryBot.build(:article, :url => "example.com/article1")

      expect(article).not_to be_valid
      expect(article.errors[:url]).to be_present
    end
  end

  describe ".recent" do
    it "returns last 10 articles" do
      FactoryBot.create(:article)
      recent_articles = FactoryBot.create_list(:article, 10)

      expect(described_class.recent).to eq(recent_articles.reverse)
    end
  end

  describe ".pending" do
    it "includes pending articles" do
      article = FactoryBot.create(:article, :pending => true)

      expect(described_class.pending).to include(article)
    end

    it "doesn't include non pending articles" do
      article = FactoryBot.create(:article, :pending => false)

      expect(described_class.pending).to be_empty
    end
  end

  describe ".search_by_street" do
    it "returns articles that have the street in the content" do
      article = FactoryBot.create(
        :article, :content => "No water in Narodnog fronta"
      )

      expect(described_class.search_by_street("Narodnog fronta"))
        .to include(article)
    end

    it "returns articles that have the street in the title" do
      article = FactoryBot.create(
        :article, :title => "No water in Narodnog fronta"
      )

      expect(described_class.search_by_street("Narodnog fronta"))
        .to include(article)
    end

    it "doesn't return articles that don't have the street in the title or the content" do
      article = FactoryBot.create(
        :article, :title => "No water in Narodnog fronta"
      )

      expect(described_class.search_by_street("Bulevar cara Lazara"))
        .to be_empty
    end

    it "returns articles that have similar street in the title" do
      article = FactoryBot.create(
        :article, :title => "No water in Banović Strahinje"
      )

      expect(described_class.search_by_street("Banovic Strahinje"))
        .to include(article)
    end
  end

  describe ".mark_all_done" do
    it "makes all articles not panding" do
      article = FactoryBot.create(:article, :pending => true)

      described_class.mark_all_done

      expect(article.reload.pending?).to be(false)
    end
  end
end
