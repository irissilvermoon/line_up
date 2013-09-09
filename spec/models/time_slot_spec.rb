require 'spec_helper'

describe TimeSlot do
  let(:club_night) { ClubNight.create(Factory.attributes_for(:club_night)) }
  let(:event)      { club_night.events.create(Factory.attributes_for(:event)) }
  let(:time_slot)  { event.time_slots.create(Factory.attributes_for(:time_slot)) }

  describe "#dj_ids=" do
    context "for existing djs" do
      let (:existing_djs) do
        existing_dj1 = Factory.create(:dj)
        existing_dj2 = Factory.create(:dj)
        existing_dj3 = Factory.create(:dj)

        [existing_dj1, existing_dj2, existing_dj3]
      end

      it "should add the correct number existing DJs to a time slot" do
        expect { time_slot.dj_ids = [existing_djs.first.id, existing_djs.second.id, existing_djs.third.id]
          }.to change{
            time_slot.djs.count
          }.to(3)
      end

      it "should include existing DJs as part of the time slot" do
        time_slot.dj_ids = existing_djs.map(&:id)
        time_slot.djs.should include(existing_djs.first, existing_djs.second, existing_djs.third)
      end
    end

    context "for non-existing djs" do
      let! (:djs) do
        existing_dj1 = Factory.create(:dj, :club_night => club_night)
        existing_dj2 = Factory.create(:dj, :club_night => club_night)
        non_existing_dj = "Quadrant"

        [existing_dj1, existing_dj2, non_existing_dj]
      end

      it "should add the correct number of DJs to a club night" do
        expect { time_slot.dj_ids = [djs.first.id, djs.second.id, djs.third]
          }.to change {
            club_night.djs.count
          }.to(3)
      end

      it "should create a new DJ" do
        expect { time_slot.dj_ids = [djs.first.id, djs.second.id, djs.third] }.to change {
          Dj.count
        }.by(1)
      end

      it "should add DJ to time slot" do
        expect { time_slot.dj_ids = [djs.first.id, djs.second.id, djs.third]
          }.to change {
            time_slot.djs.count
          }.by(3)
        # existing_djs.should be_in time_slot.djs
      end

      it "should add a DJ with the correct name" do
        expect { time_slot.dj_ids = [djs.third] }.to change {
          club_night.djs.where(:dj_name => djs.third).exists?
        }.to(true)
      end
    end
  end

  describe "#dj_id_list" do
    context "with a blank dj list" do
      before { time_slot.stub(:dj_ids => []) }

      it "should return an empty string" do
        time_slot.dj_id_list.should == ''
      end
    end

    context "with a non-blank dj list" do
      before { time_slot.stub(:dj_ids => [1, 2, 3]) }

      it "should return a comma separated list of ids" do
        time_slot.dj_id_list.should == '1,2,3'
      end
    end
  end

  describe "#dj_id_list=" do
    context "with a blank string" do
      it "should set dj_ids= with an empty array" do
        time_slot.should_receive(:dj_ids=).with([])
        time_slot.dj_id_list = ''
      end
    end

    context "with a non-blank string" do
      it "should set dj_ids= with a populated array" do
        time_slot.should_receive(:dj_ids=).with(['1', '2', '3'])
        time_slot.dj_id_list = '1,2,3'
      end
    end
  end
end

# look at ids and see if any aren't actually integers

# if they aren't, they're names. Try to find a dj for this club night w/ this name

# if the dj doesn't exist, then create one, using the genre for this night as the default, etc
# then take that dj name out of the ids array and replace it w/ the id of the newly created dj
# time_slot.dj_ids = [dj_1.id, dj_2.id, 'Johnny Monsoon']