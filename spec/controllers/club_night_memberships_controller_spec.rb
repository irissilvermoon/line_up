require 'spec_helper'

describe ClubNightMembershipsController do
  let!(:user) { Factory(:confirmed_user) }
  let!(:club_night) { user.club_nights.create(Factory.attributes_for(:club_night)) }

  before do
    sign_in(:user, user)
  end

  describe "#new" do
    it "successfully renders new" do
      get :new, :club_night_id => club_night.id
      response.should render_template("new")
    end
  end

  describe "#create" do
    context "with a user that doesn't exist" do
      it "should create a user in the system" do
        post :create, :club_night_id => club_night.id, :user => {:email => "example@example.com"}
        User.where(:email => "example@example.com").should be_present
      end

      it "should add the user to the club night" do
        post :create, :club_night_id => club_night.id, :user => { :email => "example@example.com"}
        new_user = User.where(:email => "example@example.com").first
        club_night.users(:force)
        new_user.should be_in club_night.users
      end
    end

    context 'With a user that does exist' do
      let!(:existing_user) { Factory(:confirmed_user) }

      it "should not create a user in the system" do
        expect { post :create, :club_night_id => club_night.id, :user => {:email => existing_user.email} }.to_not change {
          User.count
        }
      end
    end
  end

  describe "#show" do
    it "renders the index view" do
      get :index, :club_night_id => club_night.id
      response.should render_template("index")
    end
  end

  describe "#destroy" do
    context "With a member of a club night" do
      let!(:existing_user) { Factory(:confirmed_user) }

      before do
        club_night.users << existing_user
      end

      it "removes a user from an event" do
        expect { delete :destroy, :club_night_id => club_night.id, :id => user.id}.to change {
          club_night.users.count
        }.by(-1)
      end

      it "does not delete a user from the system" do
        expect { delete :destroy, :club_night_id => club_night.id, :id => user.id}.to_not change {
          User.count
        }
      end
    end
  end
end
