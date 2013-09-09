require 'spec_helper'

feature 'Creating DJs' do
  let!(:user) { Factory(:confirmed_user) }

  before do
    sign_in_as!(user)
    @club_night = Factory.create(:club_night, :name => "DnB Tuesdays")
    user.club_nights << @club_night
    @dj = Factory.create(:dj, :dj_name => "Iris", :club_night => @club_night)
    visit club_night_path(@club_night)
    click_link "DJs"
    click_link "Iris"
  end

  scenario 'Deleting a DJ' do
    click_link 'Delete DJ Profile'
    page.should have_content("DJ has been deleted")
    page.current_url.should == club_night_djs_url(@club_night)
  end
end