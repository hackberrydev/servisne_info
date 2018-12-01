require "rails_helper"

RSpec.describe User, :type => :model do
  describe "#make_admin" do
    it "promotes the user to admin" do
      user = FactoryBot.create(:user)
      expect(user.admin?).to be_falsy

      user.make_admin

      expect(user.admin?).to be_truthy
    end
  end
end
