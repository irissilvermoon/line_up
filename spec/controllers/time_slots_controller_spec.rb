require 'spec_helper'

describe TimeSlotsController do
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
      get :new, :club_night_id => club_night.id, :event_id => event.id
      response.should render_template("new")
    end
  end
end
