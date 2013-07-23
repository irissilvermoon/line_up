require 'spec_helper'

feature 'Creating DJs' do
  let!(:user) { Factory(:confirmed_user) }

  before do
    sign_in_as!(user)
    @club_night = Factory.create(:club_night, :name => "DnB Tuesdays")
    user.club_nights << @club_night
    @dj = Factory.create(:dj, :dj_name => "Iris", :club_night => @club_night)
    visit club_night_path(@club_night)
    click_link "Iris"
  end

  scenario 'Editing a DJ' do
    click_link 'Edit'
    fill_in "DJ Name", :with => "Quadrant"
    click_button "Update Dj"
    page.should have_content("Quadrant's profile has been updated.")
  end

  scenario 'Editing a DJ with invalid parameters' do
    click_link "Edit"
    fill_in "DJ Name", :with => ""
    click_button 'Update Dj'
    page.should have_content("Profile has not been updated.")
  end
end