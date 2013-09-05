FactoryGirl.define do
  factory :dj do
    sequence (:dj_name) { |n| "Iris#{n}" }
  end
end