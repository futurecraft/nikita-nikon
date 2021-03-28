# frozen_string_literal: true

# Factory to create order records

FactoryBot.define do

  factory :order, class: Hash do
    id { rand(1000..9999) }
    petId	{ rand(1000..9999) }
    quantity { rand(10) }
    shipDate { Time.now.strftime("%Y-%m-%dT%H:%M:%S.000+00:00") }
    status { %w(placed approved delivered).sample }
    complete { [true, false].sample }

    initialize_with { attributes }
  end

end