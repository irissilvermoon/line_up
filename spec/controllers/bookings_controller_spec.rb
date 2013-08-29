require 'spec_helper'

describe BookingsController do
  let!(:user) { Factory(:confirmed_user) }
  let!(:club_night) { user.club_nights.create(Factory.attributes_for(:club_night)) }
  let!(:event) { club_night.events.create(Factory.attributes_for(:event)) }
  let!(:time_slot) { Factory(:time_slot,
                             :event => event,
                             :genres => "DnB") }
  let!(:dj) { Factory(:dj,
                      :club_night => club_night,
                      :dj_name => "Iris",
                      :name => "Karen") }


  before do
    sign_in(:user, user)
    club_night.users << user
  end

  describe "#new" do
    it "successfully renders new" do
      get :new, :time_slot_id => time_slot.id
      response.should render_template("new")
    end

    context "with a user that is not a member of a club night" do
      let!(:existing_user) { Factory(:confirmed_user) }

      before do
        sign_in(:user, existing_user)
      end

      it "should not render new for users not part of a club night" do
        expect { get :new, :time_slot_id => time_slot.id }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "#create" do
    context "with a Dj that exists" do
      let!(:dj) { Factory(:dj, :dj_name => "Iris")}

      before do
        club_night.djs << dj
      end

      it "successfully adds a DJ to a time slot" do
        expect {
          post :create, :time_slot_id => time_slot.id, :booking => { dj_id: dj.id }
         }.to change {
          time_slot.bookings.count
         }.by(1)
      end
    end
  end

  describe "#destroy" do
    it "removes a DJ from a time slot" do
      expect {
        delete :destroy, :time_slot_id => time_slot.id, :id => booking.id
      }.to change {
        time_slot.bookings.count
      }.by(-1)
    end

    it "does not delete a DJ from the system" do
      expect {
        delete :destroy, :time_slot_id => time_slot.id, :id => booking.id
      }.to_not change {
        Dj.count
      }
    end
  end
end
