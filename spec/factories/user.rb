# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name 'Ruslan'
    last_name 'Oliinyk'
    email '1@2.ua'
    phone '380961234567'
    password '123456'
  end

  factory :rand_user, class: User do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    password { Faker::Internet.password(6) }
  end
end
