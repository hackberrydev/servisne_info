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

  scenario "The admin deletes a user" do
    visit admin_users_path

    within "#user_#{@user.id}" do
      click_link "Delete"
    end

    expect(page).to have_content("User was succesfully deleted.")
    expect(page).not_to have_content(@user.email)
  end

  scenario "The admin updates a user" do
    visit admin_users_path

    within "#user_#{@user.id}" do
      click_link "Edit"
    end

    fill_in "Streets", with: "Bulevar"
    check "kać"
    check "novi sad"
    click_button "Save"

    expect(page).to have_content("User was succesfully saved.")
    within "#user_#{@user.id}" do
      expect(page).to have_content("Bulevar")
      expect(page).to have_content("kać, novi sad")
    end
  end

  scenario "The admin tries to set streets to blank value" do
    visit edit_admin_user_path(@user)

    fill_in "Streets", with: ""
    click_button "Save"

    expect(page).to have_content("Ulice je obavezno polje")
  end
end
