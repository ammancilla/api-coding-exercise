if Rails.env.development?
  5.times do
    ge = GroupEvent.new(user_id: 1, name: Faker::Name.name, start_on: Faker::Date.forward(1), duration: 5)
    ge.save!

    ge = GroupEvent.create!(user_id: 1, end_on: Faker::Date.forward(50) + 11, duration: 10)
    ge.save!

    ge = GroupEvent.create!(
      user_id: 1, 
      name: Faker::Name.name,
      description: Faker::Lorem.paragraph,
      location: Faker::Address.street_address,
      start_on: Faker::Date.forward(1),
      end_on: Faker::Date.forward(50)
    )
    ge.save!
  end
end