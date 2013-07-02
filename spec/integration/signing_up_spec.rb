require 'spec_helper'

feature 'Signing up' do
  scenario 'Successful sign up' do
    visit '/'
    click_link 'Sign up'
    fill_in "Email", :with => "iris@qadrantsound.com"
    fill_in "Password", :with => "Password"
    fill_in "Password confirmation", :with => "Password"
    click_button "Sign up"
    message = "Please open the link to activate your account."
    page.should have_content("Please confirm your account before signing in.")
  end
end