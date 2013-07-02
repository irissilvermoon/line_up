FactoryGirl.define do
  factory :user do
    email "user@user.com"
    password "password"
    password_confirmation "password"

    factory :confirmed_user do
      sequence(:email) { |n| "user#{n}@user.com" }
      after_create do |user|
        user.confirm!
      end
    end
  end
end