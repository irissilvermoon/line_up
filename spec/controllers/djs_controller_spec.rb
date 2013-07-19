require 'spec_helper'

describe DjsController do
  let!(:user) { Factory(:confirmed_user) }
  let!(:club_night) {Factory(:club_night) }
  let(:dj) { Factory(:dj,
                     :club_night => club_night,
                     :dj_name => "Iris",
                     :name => "Karen") }

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
    it "successfully creates a new DJ" do
      expect { post :create, :dj_id => dj.id }.to change {
        club_night.djs.count
      }.by(1)
    end
  end

  describe "#show" do
    it "renders show view for DJ profile" do
      get :show, id: Factory(:dj)
      response.should render_template("show")
    end
  end

  describe "#edit" do
    it "renders edit" do
      get :edit, id: Factory(:dj)
      response.should render_template("edit")
    end
  end

  describe "#destroy" do
    it "deletes a dj" do
      delete :destroy, id: Factory(:dj)
      response.should redirect_to club_night_url
    end
  end
end
