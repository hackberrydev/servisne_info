require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it "requires presence of streets" do
      user = FactoryBot.build(:user)
      user.streets = ""

      expect(user.valid?).to be_falsy
      expect(user.errors[:streets]).to be_present
    end

    it "allows only available towns" do
      user = FactoryBot.build(:user, towns: User::AVAILABLE_TOWNS)

      expect(user).to be_valid
    end

    it "is invalid when towns include entries not in AVAILABLE_TOWNS" do
      user = FactoryBot.build(:user, towns: ["invalid town"])
      user.valid?

      expect(user.errors[:towns]).to include("sadrže opciju koja nije validna")
    end
  end

  describe "callbacks" do
    describe "before validate" do
      it "transforms towns to be all lower letter" do
        user = FactoryBot.build_stubbed(:user)
        user.towns = ["Novi Sad", "Belgrade"]

        user.validate

        expect(user.towns).to match_array(["novi sad", "belgrade"])
      end
    end
  end

  describe "#make_admin" do
    it "promotes the user to admin" do
      user = FactoryBot.create(:user)
      expect(user.admin?).to be_falsy

      user.make_admin

      expect(user.admin?).to be_truthy
    end
  end

  describe "#streets_array" do
    it "returns array of streets" do
      user = FactoryBot.build(:user, streets: "Banovic Strahinje, Bulevar, Liman")

      expect(user.streets_array).to eq(["Banovic Strahinje", "Bulevar", "Liman"])
    end
  end

  describe "#search_pending_articles" do
    before do
      @user = FactoryBot.create(:user, streets: "Banovic Strahinje", towns: ["novi sad"])
    end

    it "returns pending articles with matching street and town" do
      article = FactoryBot.create(
        :article,
        :pending,
        title: "No water in Banovic Strahinje",
        town: "novi sad"
      )

      expect(@user.search_pending_articles).to include(article)
    end

    it "doesn't return articles that are not pending" do
      article = FactoryBot.create(
        :article,
        :sent,
        title: "No water in Banovic Strahinje",
        town: "novi sad"
      )

      expect(@user.search_pending_articles).not_to include(article)
    end

    it "doesn't return articles where streets don't match" do
      article = FactoryBot.create(
        :article,
        :pending,
        title: "No water in Bulevar cara Lazara",
        town: "novi sad"
      )

      expect(@user.search_pending_articles).not_to include(article)
    end

    it "doesn't return articles where town doesn't match" do
      article = FactoryBot.create(
        :article,
        :pending,
        title: "No water in Banovic Strahinje",
        town: "subotica"
      )

      expect(@user.search_pending_articles).not_to include(article)
    end
  end
end
