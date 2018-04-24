# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    start { Faker::Address.street_address }
    destination { Faker::Address.street_address }
    price { Faker::Commerce.price }
    weight { rand(500) }
    date { Faker::Date.forward(30) }
  end
end
