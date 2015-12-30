require 'spec_helper'

describe DjsController do
  let!(:user) { FactoryGirl.create(:confirmed_user) }
  let!(:club_night) { user.club_nights.create(FactoryGirl.attributes_for(:club_night)) }
  let!(:dj) { FactoryGirl.create(:dj,
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

  describe "#index" do
    it "should succeed" do
      get :index, :club_night_id => club_night.id
      response.should be_success
    end

    context "requesting json" do
      # Let's add a few more DJs to the list so the tests are more interesting.
      [:quadrant, :kid_hops, :total_science].each do |name|
        let!(name) do
          club_night.djs.create(dj_name: name.to_s.titleize)
        end
      end

      it "should list the djs" do
        get :index, :club_night_id => club_night.id, :format => 'json'

        response.body.should == club_night.djs.to_json
      end

      context "with a search query" do
        it "should include the djs in the query" do
          get :index, :club_night_id => club_night.id, :format => 'json', :q => 'a'

          # This is really an array of Dj attribute hashes
          array_of_djs = JSON.parse(response.body)
          dj_names     = array_of_djs.map { |dj| dj['dj_name'] }

          expect(dj_names).to include('Quadrant', 'Total Science')
        end

        it "should not include djs that don't match the query" do
          get :index, :club_night_id => club_night.id, :format => 'json', :q => 'a'

          array_of_djs = JSON.parse(response.body)
          dj_names     = array_of_djs.map { |dj| dj['dj_name'] }

          expect(dj_names).to_not include('Kid Hops', 'Iris')
        end

        it "should return a sentinel if the query doesn't return any results" do
          get :index, :club_night_id => club_night.id, :format => 'json', :q => "Calyx"
          expect(JSON.parse(response.body)).to eql([{'dj_name' => 'New DJ: Calyx', 'id' => 'Calyx'}])
        end
      end
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

  describe "#update" do
    it "updates DJ profile" do
      put :update, club_night_id: club_night.id, :id => dj.id,
      dj: FactoryGirl.attributes_for(:dj, :dj_name => "Quadrant")
      dj.reload
      dj.dj_name.should eq("Quadrant")
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
      response.should redirect_to club_night_djs_url
    end
  end
end
