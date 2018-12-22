require "rails_helper"

feature "Update account" do
  include AuthenticationHelpers
  
  scenario "A user updates account" do
    user = FactoryBot.create(:user)
    
    sign_in(user.email, "pass123")
    visit edit_user_registration_path
    fill_in "Email", :with => "my_new@example.com"
    fill_in "Ulice", :with => "My new street"
    fill_in "Trenutna lozinka", :with => "pass123"
    click_button "Sačuvaj"
    
    expect(page).to have_content("Uspešno ste аžurirаli svoj nаlog.")
    expect(page).to have_field("Email", :with => "my_new@example.com")
    expect(page).to have_field("Ulice", :with => "My new street")
  end
end