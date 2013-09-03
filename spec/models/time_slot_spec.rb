require 'spec_helper'

describe TimeSlot do
  describe "#dj_ids=" do
    it "should check ids for non-integers" do
    end

    it "should find ids for names given" do
    end

    it "should create a DJ if name is not found" do
    end
  end
end

# look at ids and see if any aren't actually integers

# if they aren't, they're names. Try to find a dj for this club night w/ this name

# if the dj doesn't exist, then create one, using the genre for this night as the default, etc
# then take that dj name out of the ids array and replace it w/ the id of the newly created dj
