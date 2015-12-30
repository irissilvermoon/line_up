require 'spec_helper'


feature 'Creating DJs' do
  let!(:user) { FactoryGirl.create(:confirmed_user) }

  before do
    sign_in_as!(user)
    @club_night = FactoryGirl.create(:club_night, :name => "DnB Tuesdays")
    user.club_nights << @club_night
    visit club_night_path(@club_night)
    click_link "Add a DJ to DnB Tuesdays"
  end

  scenario 'Creating a new DJ' do
    fill_in "DJ Name", :with => "Iris"
    click_button 'Create Dj'
    page.should have_content("Iris's profile has been created.")
  end

  scenario 'Creating a DJ with invalid parameters' do
    fill_in "DJ Name", :with => ""
    click_button 'Create Dj'
    page.should have_content("DJ profile has not been created.")
  end
end