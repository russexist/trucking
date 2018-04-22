# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    start 'Енгельса 162'
    destination 'Хрещатик 200'
    price '200'
    weight '120'
    date '21.01.2018'
  end

  factory :rand_order, class: Order do
    start { Faker::Address.street_address }
    destination { Faker::Address.street_address }
    price { Faker::Commerce.price }
    weight { rand(500) }
    date { Faker::Date.forward(30) }
  end
end
