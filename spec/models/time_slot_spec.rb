require 'spec_helper'

describe TimeSlot do
  describe "#dj_ids=" do
    let(:club_night) { ClubNight.create(Factory.attributes_for(:club_night))}
    let(:event) { club_night.events.create(Factory.attributes_for(:event))}
    let(:time_slot) {event.time_slots.create(Factory.attributes_for(:time_slot))}


    context "for existing djs" do
      let (:existing_djs) do
        existing_dj1 = Factory.create(:dj)
        existing_dj2 = Factory.create(:dj)
        existing_dj3 = Factory.create(:dj)

        existing_djs = [existing_dj1, existing_dj2, existing_dj3]
      end

      it "should add the correct number existing DJs to a time slot" do
        expect { time_slot.dj_ids = [existing_djs.first.id, existing_djs.second.id, existing_djs.third.id]
          }.to change{
            time_slot.djs.count
          }.to(3)
      end
    end

    context "for non-existing djs" do
      let (:existing_djs) do
        existing_dj1 = Factory.create(:dj)
        existing_dj2 = Factory.create(:dj)
        non_existing_dj = "Quadrant"

        existing_djs = [exsiting_dj1, existing_dj2, non_existing_dj]
      end

      it "should create and add DJ to a club night" do
        .should be_in time_slot.djs
        .should be_in club_night.djs
      end

      it "should add DJ to time slot"
    end
  end
end

# look at ids and see if any aren't actually integers

# if they aren't, they're names. Try to find a dj for this club night w/ this name

# if the dj doesn't exist, then create one, using the genre for this night as the default, etc
# then take that dj name out of the ids array and replace it w/ the id of the newly created dj
# time_slot.dj_ids = [dj_1.id, dj_2.id, 'Johnny Monsoon']