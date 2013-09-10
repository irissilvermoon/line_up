require 'spec_helper'

describe TimeSlotsController do
  let!(:user) { Factory(:confirmed_user) }
  let!(:club_night) { user.club_nights.create(Factory.attributes_for(:club_night)) }
  let!(:event) { club_night.events.create(Factory.attributes_for(:event)) }
  let!(:time_slot) { Factory(:time_slot,
                             :event => event,
                             :genres => "DnB") }
  let!(:dj) { Factory(:dj, club_night: club_night) }

  before do
    sign_in(:user, user)
  end

  describe "#new" do
    it "successfully renders new" do
      get :new, :club_night_id => club_night.id, :event_id => event.id
      response.should render_template("new")
    end
  end

  describe "#create" do
    it "successfully creates a new time slot" do
      expect {
        post :create, :club_night_id => club_night.id, :event_id => event.id,
          time_slot: Factory.attributes_for(:time_slot, dj_id_list: dj.id)
      }.to change {
          event.time_slots.count
      }.by(1)
    end

    it "should add a booking for the dj" do
      expect {
        post :create, :club_night_id => club_night.id, :event_id => event.id,
          time_slot: Factory.attributes_for(:time_slot, dj_id_list: dj.id)
      }.to change {
          dj.bookings.count
      }.by(1)
    end

    context "adding a new dj" do
      let(:time_slot_attrs) do
        attrs = Factory.attributes_for(:time_slot, dj_id_list: "New Rad DJ")
      end

      it "should not error" do
        expect { post :create, :club_night_id => club_night.id, :event_id => event.id, :time_slot => time_slot_attrs }.to_not raise_error
      end
    end
  end

  describe "#show" do
    it "renders show view for time slots" do
      get :show, :club_night_id => club_night.id, :event_id => event.id, :id => time_slot.id
      response.should render_template("show")
    end
  end

  describe "#edit" do
    it "renders edit" do
      get :edit, :club_night_id => club_night.id, :event_id => event.id, :id => time_slot.id
      response.should render_template("edit")
    end
  end

  describe "#update" do
    it "updates an event" do
      put :update, :club_night_id => club_night.id, :event_id => event.id, :id => time_slot.id,
      :time_slot => Factory.attributes_for(:time_slot, :genres => "House", dj_id_list: "#{dj.id}")
      time_slot.reload
      time_slot.genres.should eq("House")
    end
  end

  describe "#delete" do
    it "Deletes an event" do
      expect {
        delete :destroy, :club_night_id => club_night.id, :event_id => event.id, :id => time_slot.id
      }.to change {
        event.time_slots.count
      }.by(-1)
    end
  end
end
