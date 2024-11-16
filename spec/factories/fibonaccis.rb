# frozen_string_literal: true

FactoryBot.define do
  factory :fibonacci do
    sequence(:position) { |n| n }
    value { '1' }
  end
end
