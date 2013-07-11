module AuthenticationHelpers
  def sign_in_as!(user)
    visit '/users/sign_in'
    fill_in "Email", :with => user.username
    fill_in "Password", :with => "password"
    click_button 'Sign in'
    page.should have_content("Signed In successfully.")
  end
end

Rspec.configure do |c|
  c.include AuthenticationHelpers, :type => :request
end