require 'spec_helper'

feature 'Creating Club Nights' do
    let!(:user) { FactoryGirl.create(:confirmed_user) }

  before do
    sign_in_as!(user)
    visit '/'
    click_link "Create New Club Night"
  end

  scenario "It can create a new Club Night" do
    fill_in "Club Night Name", :with => "Dnb Tuesdays"
    fill_in 'Start time', :with => "8/22/2013 9:00pm"
    fill_in 'End time', :with => "8/22/2013 2:00am"
    click_button "Create Club night"
    page.should have_content("The club night Dnb Tuesdays has been created.")
  end

  scenario "Cannot create a club night without a name" do
    click_button "Create Club night"
    page.should have_content("Club Night has not been created.")
    page.should have_content("can't be blank")
  end
end