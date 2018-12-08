require "rails_helper"

feature "Update account" do
  include AuthenticationHelpers
  
  scenario "A user updates account" do
    user = FactoryBot.create(:user)
    
    sign_in(user.email, "pass123")
    visit edit_user_registration_path
    fill_in "Email", :with => "my_new@example.com"
    fill_in "Streets", :with => "My new street"
    fill_in "Current password", :with => "pass123"
    click_button "Save"
    
    expect(page).to have_content("Your account has been updated successfully.")
    expect(page).to have_field("Email", :with => "my_new@example.com")
    expect(page).to have_field("Streets", :with => "My new street")
  end
end