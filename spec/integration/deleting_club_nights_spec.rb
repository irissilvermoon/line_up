require 'spec_helper'

feature 'Deleting club nights' do
  let!(:user) { Factory(:confirmed_user) }

  before do
    sign_in_as!(user)
    @club_night = Factory.create(:club_night, :name => "DnB Tuesdays",
                                              :start_time => Time.parse("21/7/2013 9:00pm"),
                                              :end_time => Time.parse("22/7/2013 2:00am"))
    user.club_nights << @club_night
  end

  scenario "Deleting a club night" do
    visit club_night_path(@club_night)
    click_link 'Delete'
    page.should have_content("Club night has been deleted")
    page.current_url.should == dashboard_url
  end
end