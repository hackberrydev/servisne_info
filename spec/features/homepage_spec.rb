require "rails_helper"

feature "Homepage" do
  scenario "A visitors sees the homepage" do
    visit root_path
    expect(page).to have_content("Hackberry Rails Starter App")
  end
end
