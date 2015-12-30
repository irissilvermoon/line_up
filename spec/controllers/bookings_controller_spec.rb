require 'spec_helper'

describe BookingsController do
  let!(:user) { FactoryGirl.create(:confirmed_user) }
  let!(:club_night) { user.club_nights.create(FactoryGirl.attributes_for(:club_night)) }
  let!(:event) { club_night.events.create(FactoryGirl.attributes_for(:event)) }
  let!(:time_slot) { FactoryGirl.create(:time_slot,
                             :event => event,
                             :genres => "DnB") }

  let!(:dj) { FactoryGirl.create(:dj,
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
      let!(:existing_user) { FactoryGirl.create(:confirmed_user) }

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
      let!(:dj) { FactoryGirl.create(:dj, :dj_name => "Iris")}

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

    context "with a Dj already added to a time slot" do
      let!(:booking) { time_slot.bookings.create(FactoryGirl.attributes_for(:booking))}

      before do
        time_slot.bookings << booking
      end

      it "should not add a DJ to a time slot twice" do
        expect {
          post :create, :time_slot_id => time_slot.id, :booking => {dj_id: dj.id }
        }.to_not change {
          time_slot.bookings.count
        }
      end
    end
  end

  describe "#destroy" do
    context "with a DJ already added to a time slot" do
      let!(:booking) { time_slot.bookings.create(FactoryGirl.attributes_for(:booking)) }

      before do
        time_slot.bookings << booking
      end

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
end
