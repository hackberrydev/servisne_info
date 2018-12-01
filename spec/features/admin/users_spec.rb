require "rails_helper"

feature "Users admin" do
  include AuthenticationHelpers

  before do
    @admin = FactoryBot.create(:user, :admin)
    @user = FactoryBot.create(:user)

    sign_in(@admin.email, "pass123")
  end

  scenario "The admin sees all users" do
    visit admin_users_path

    expect(page).to have_content(@admin.email)
    expect(page).to have_content(@user.email)
  end
end

