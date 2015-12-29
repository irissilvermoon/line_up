class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :invitable

  # attr_accessible :title, :body
  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :club_nights, :through => :club_night_memberships
  has_many :club_night_memberships
end
