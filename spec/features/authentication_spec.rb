require "rails_helper"

feature "Authentication" do
  include AuthenticationHelpers

  scenario "A visitor creates an account" do
    sign_up("john@example.com", "pass123")
    expect(page).to have_content("You have signed up successfully.")
  end

  scenario "A visitor signs in and out" do
    user = FactoryBot.create(:user)

    sign_in(user.email, "pass123")
    expect(page).to have_content("Signed in successfully.")

    sign_out
    expect(page).to have_content("Signed out successfully.")
  end
end
