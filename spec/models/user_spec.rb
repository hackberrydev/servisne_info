require "rails_helper"

RSpec.describe User, :type => :model do
  describe "validations" do
    it "requires presence of streets" do
      user = FactoryBot.build(:user)
      user.streets = ""
      
      expect(user.valid?).to be_falsy
      expect(user.errors[:streets]).to be_present
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
      user = FactoryBot.build(:user, :streets => "Banovic Strahinje, Bulevar, Liman")
      
      expect(user.streets_array).to eq(["Banovic Strahinje", "Bulevar", "Liman"])
    end
  end
end
