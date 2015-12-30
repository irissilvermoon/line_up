require 'spec_helper'

describe ConfirmationsController do
  let!(:user) { FactoryGirl.create(:confirmed_user) }
  let!(:club_night) { user.club_nights.create(FactoryGirl.attributes_for(:club_night)) }
  let!(:event) { club_night.events.create(FactoryGirl.attributes_for(:event)) }
  let!(:time_slot) { FactoryGirl.create(:time_slot,
                             :event => event,
                             :genres => "DnB") }
  let!(:dj) { FactoryGirl.create(:dj, club_night: club_night) }

  before do
    sign_in(:user, user)
  end

  describe "#create" do
    it "should add confirmed to time slot" do
      post :create, :time_slot_id => time_slot.id
      time_slot.reload.confirmed_by.should == user
    end
  end

  describe "#destroy" do
    before do
      time_slot.confirmed_by = user
      time_slot.save
    end

    it "should allow users to undo confirmations" do
      delete :destroy, :time_slot_id => time_slot.id
      time_slot.reload.confirmed_by.should == nil
    end
  end
end
