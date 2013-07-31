require 'spec_helper'

describe Event do
  describe '#date=' do
    it "should display american date, not european" do
      event = Event.new(:date => '8/13/2013')
      event.date.should == Time.parse('8/13/2013')
    end
  end
end
