require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the DjsHelper. For example:
#
# describe DjsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe DjsHelper do
  describe "external_link" do
    it "should return nil if the link is empty" do
      dj = Dj.new
      dj.facebook.should == nil
    end

    it "should return http://www.soundcloud.com/iris1" do
      dj = Dj.new(:facebook => "http://www.soundcloud.com/iris1")
      dj.facebook.should == "http://www.soundcloud.com/iris1"
    end

    it "should insert http:// on facebook links where missing" do
      dj = Dj.new(:facebook => "www.soundcloud.com/iris1")
      dj.facebook.should == "http://www.soundcloud.com/iris1"
    end

    it "should not insert http:// on facebook links if no link given" do
      dj = Dj.new(:facebook => "")
      dj.facebook.should_not == "http://"
    end
  end
end
