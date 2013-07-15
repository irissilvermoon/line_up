require 'spec_helper'

describe ClubNightsController do
  let(:user) { Factory(:confirmed_user) }
  let(:club_night) {Factory(:club_night,
                            :name => "DnBTuesdays",
                            :venue => "Baltic Room") }

  before do
    sign_in(:user, user)
  end

  describe "#new" do
    it "successfully renders new" do
      get :new
      response.should render_template("new")
    end
  end

  describe "#create" do
    it "successfully creates a new club night" do
      expect { post :create, :club_night_id => club_night.id }.to change {
        user.club_nights.count
      }.by(1)
    end
  end

  describe "#show" do
    it "renders show view for club night" do
      get :show, id: Factory(:club_night)
      response.should render_template("show")
    end
  end

  describe "#edit" do
    it "renders edit" do
      get :edit, id: Factory(:club_night)
      response.should render_template("edit")
    end
  end

  describe "#destroy" do
    it "deletes a club night" do
      delete :destroy, id: Factory(:club_night)
      response.should redirect_to dashboard_url
    end
  end
end
