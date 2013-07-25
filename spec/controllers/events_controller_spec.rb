require 'spec_helper'

describe EventsController do
  let!(:user) { Factory(:confirmed_user) }
  let!(:club_night) { user.club_nights.create(Factory.attributes_for(:club_night)) }
  let!(:event) { Factory(:event,
                         :club_night => club_night,
                         :name => "DnB Tuesdays") }

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
    it "successfully creates a new event" do
      expect {
        post :create, :club_night_id => club_night.id, event: Factory.attributes_for(:event)
        }.to change {
          club_night.events.count
        }.by(1)
    end
  end

  describe "#show" do
    it "renders show view for events" do
      get :show, :club_night_id => club_night.id, :id => event.id
      response.should render_template("show")
    end
  end

  describe "#edit" do
    it "renders edit" do
      get :edit, :club_night_id => club_night.id, :id => event.id
      response.should render_template("edit")
    end
  end

  describe "#update" do
    it "updates an event" do
      put :update, :club_night_id => club_night.id, :id => event.id,
      :event => Factory.attributes_for(:event, :name => "DnB Wednesdays")
      event.reload
      event.name.should eq("DnB Wednesdays")
    end
  end

  describe "#destroy" do
    it "deletes an event" do
      expect {
        delete :destroy, :club_night_id => club_night.id, :id => event.id }.to change{
          club_night.events.count
        }.by(-1)
    end
  end

  describe "#destroy-redirect" do
    it "redirects after an event is deleted" do
      delete :destroy, club_night_id: club_night.id, :id => event.id
      response.should redirect_to club_night_url
    end
  end
end

