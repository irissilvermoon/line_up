require 'spec_helper'

describe BookingsController do
  let!(:user) { Factory(:confirmed_user) }
  let!(:club_night) { user.club_nights.create(Factory.attributes_for(:club_night)) }
  let!(:event) { club_night.events.create(Factory.attributes_for(:event)) }
  let!(:time_slot) { Factory(:time_slot,
                             :event => event,
                             :genres => "DnB") }

  before do
    sign_in(:user, user)
  end

  describe "#new" do
    it "successfully renders new" do
      get :new, :time_slot_id => time_slot.id
      response.should render_template("new")
    end
  end

  describe "#create" do
    it "successfully adds a DJ to a time slot" do
    end
  end

  describe "#destroy" do
    it "removes a DJ from a time slot" do
    end
  end
end
