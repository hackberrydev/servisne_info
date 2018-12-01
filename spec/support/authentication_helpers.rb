module AuthenticationHelpers
  def sign_up(email, password)
    visit root_path
    find("nav").click_link("Sign up")
    fill_in "Email", :with => email
    fill_in "Password", :with => password
    fill_in "Password confirmation", :with => "pass123"
    click_button "Sign up"
  end

  def sign_in(email, password = "pass123")
    visit root_path
    find("nav").click_link("Sign in")
    fill_in "Email", :with => email
    fill_in "Password", :with => password
    click_button "Sign in"
  end

  def sign_out
    click_link "Sign out"
  end
end
