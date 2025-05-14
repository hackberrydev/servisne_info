require "rails_helper"

feature "Authentication" do
  include AuthenticationHelpers

  scenario "A visitor creates an account" do
    sign_up("john@example.com", "pass123", "Baker street", "Dunav")
    expect(page).to have_content("Uspešno ste se prijаvili.")

    expect(User.last.towns).to eq(["novi sad"])
  end

  scenario "A visitor tries to create an account with a wrong captcha answer" do
    sign_up("john@example.com", "pass123", "Baker street", "Tisa")
    expect(page).to have_content("Odgovor na sigurnosno pitanje nije tačan.")
  end

  scenario "A visitor signs in and out" do
    user = FactoryBot.create(:user)

    sign_in(user.email, "pass123")
    expect(page).to have_content("Uspešno ste se prijаvili.")

    sign_out
    expect(page).to have_content("Uspešno ste se odjavili.")
  end
end
