require 'spec_helper'

describe ClubNightsController do
	let(:user) { Factory(:confirmed_user) }
	let(:club_night) {Factory(:club_night,
														:name => "DnBTuesdays",
														:venue => "Baltic Room") }

	before do
		sign_in(:user, user)
	end

	describe "#new" do
		it "successfully renders new" do
			get :new
			response.should render_template("new")
		end
	end

	describe "#create" do

	end

	describe "#show" do
	end

	describe "#edit" do
	end

	describe "#destroy" do
	end
end
