require 'spec_helper'

feature 'inviting users' do
  let!(:user) { Factory(:confirmed_user) }

  before do
    sign_in_as!(user)
    @club_night = Factory.create(:club_night, :name => "DnB Tuesdays",
                                              :start_time => Time.parse("21/7/2013 9:00pm"),
                                              :end_time => Time.parse("22/7/2013 2:00am"))
    user.club_nights << @club_night
    visit club_night_path(@club_night)
    click_link "Invite Collaborator to DnB Tuesdays"
  end

  scenario 'inviting a user to join DJBookr' do
    fill_in "Email", :with => "new_user@djbookr.com"
    click_button "Send an invitation"
    page.should have_content("An invitation email has been sent to new_user@djbookr.com")
  end

  scenario 'User can sign up via invite' do
    fill_in "Email", :with => "new_user@djbookr.com"
    click_button "Send an invitation"
    visit dashboard_path
    click_link "Sign out"
    open_email "new_user@djbookr.com", :with_subject => "Invitation to Collaborate on DJBookr"
    User.first.confirmation_token
    current_email.body
    click_email_link_matching(/invitation/)
    page.should have_content("Set your password")
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "password"
    click_button "Set my password"
    page.should have_content("Your password was set successfully. You are now signed in.")
  end
end