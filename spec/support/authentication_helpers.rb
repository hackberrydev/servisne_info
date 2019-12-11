module AuthenticationHelpers
  def sign_up(email, password, streets, captcha_answer)
    visit root_path
    find("nav").click_link("Registruj se")
    fill_in "Email", :with => email
    fill_in "Lozinka", :with => password
    fill_in "Potvrda lozinke", :with => password
    fill_in "Ulice", :with => streets
    fill_in "captcha_answer", :with => captcha_answer
    click_button "Registruj se"
  end

  def sign_in(email, password = "pass123")
    visit root_path
    find("nav").click_link("Prijavi se")
    fill_in "Email", :with => email
    fill_in "Lozinka", :with => password
    click_button "Prijavi se"
  end

  def sign_out
    click_link "Odjavi se"
  end
end
