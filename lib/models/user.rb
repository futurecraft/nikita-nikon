# frozen_string_literal: true

# Factory to create user records

FactoryBot.define do

  factory :user, class: Hash do
    id { rand(1000..9999) }
    username { Faker::Internet.username }
    firstName { Faker::Name.first_name }
    lastName { Faker::Name.last_name }
    email { Faker::Internet.email(domain: 'nikitanikon.com') }
    password { Faker::Internet.password }
    phone { rand(10 ** 10).to_s }
    userStatus { 1 }

    initialize_with { attributes }
  end

end