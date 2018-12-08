require "rails_helper"

feature "Homepage" do
  scenario "A visitors sees the homepage" do
    FactoryBot.create(:article, :title => "No water tomorrow")
    FactoryBot.create(:article, :title => "No power on Saturday")
    
    visit root_path
    expect(page).to have_content("Hackberry Rails Starter App")
    expect(page).to have_link("No water tomorrow")
    expect(page).to have_link("No power on Saturday")
  end
end
