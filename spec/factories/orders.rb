# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    start 'Енгельса 162, Черкаси'
    destination 'Чигиринська, 70, Черкаси'
    price { Faker::Commerce.price }
    weight { rand(500) }
    date { Faker::Date.forward(30) }
  end
end
