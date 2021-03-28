# frozen_string_literal: true

# Factory to create pet records

FactoryBot.define do

  factory :pet, class: Hash do
    id { rand(1000..9999) }
    name { Faker::Creature::Dog.name }
    category { {
      'id' => rand(10..100),
      'name' => %w(dog cat parrot hamster).sample
    } }
    photoUrls { Array.new(rand(1..3)) { Faker::Internet.url(path: "/pic_#{rand(100)}.png") } }
    tags { [
      {
      'id' => rand(10..100),
      'name' => %w(cute angry rabies).sample
      }
    ] }
    status { %w(available pending sold).sample }

    initialize_with { attributes }
  end

end