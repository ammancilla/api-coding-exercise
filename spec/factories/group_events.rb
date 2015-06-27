FactoryGirl.define do
  factory :group_event do
    user_id 1 
    name { Faker::Name.name }
    description { Faker::Lorem.paragraph }
    location { Faker::Address.street_address }
    start_on { Faker::Date.forward(1) }
    end_on { Faker::Date.forward(50) + 1 }
  end
end