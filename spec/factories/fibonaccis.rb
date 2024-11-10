FactoryBot.define do
  factory :fibonacci do
    sequence(:position) { |n| n }
    value { 1 }
  end
end
