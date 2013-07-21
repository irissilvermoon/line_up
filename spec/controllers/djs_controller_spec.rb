require 'spec_helper'

describe DjsController do
  let!(:user) { Factory(:confirmed_user) }
  let!(:club_night) { user.club_nights.create(Factory.attributes_for(:club_night)) }
  let!(:dj) { Factory(:dj,
                     :club_night => club_night,
                     :dj_name => "Iris",
                     :name => "Karen") }

  before do
    sign_in(:user, user)
  end

  describe "#new" do
    it "successfully renders new" do
      get :new, club_night_id: club_night.id
      response.should render_template("new")
    end
  end

  describe "#create" do
    it "successfully creates a new DJ" do
      expect {
        post :create, :club_night_id => club_night.id, :dj => { dj_name: "Iris" }
      }.to change {
        club_night.djs.count
      }.by(1)
    end
  end

  describe "#show" do
    it "renders show view for DJ profile" do
      get :show, club_night_id: club_night.id, :id => dj.id
      response.should render_template("show")
    end
  end

  describe "#edit" do
    it "renders edit" do
      get :edit, club_night_id: club_night.id, :id => dj.id
      response.should render_template("edit")
    end
  end

  describe "#destroy" do
    it "deletes a DJ" do
      expect {
        delete :destroy, :club_night_id => club_night.id, :id => dj.id }.to change {
        club_night.djs.count
      }.by(-1)
    end
  end

  describe "#destroy-redirect" do
    it "redirects after a dj is deleted" do
      delete :destroy, club_night_id: club_night.id, :id => dj.id
      response.should redirect_to club_night_url
    end
  end
end
