require 'spec_helper'

feature 'Editing Club Nights' do
  let!(:user) { Factory(:confirmed_user) }

  before do
    sign_in_as!(user)
    @club_night = Factory.create(:club_night, :name => "DnB Tuesdays", :user => user)
    visit club_night_path(@club_night)
    click_link 'Edit'
  end

  scenario 'Editing a club night' do
    fill_in "Title", :with => "DnB Wednesdays"
    click_button "Update Club night"
    page.should have_content("DnB Wednesdays has been updated.")
  end

  scenario 'Editing a club night with invalid attributes' do
    fill_in "Title", :with => ""
    click_button "Update Club night"
    page.should have_content("has not been updated.")
  end
end