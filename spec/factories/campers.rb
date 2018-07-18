FactoryBot.define do
  factory :camper do
    name  { Faker::Name.name }
    campsite
  end
end


# can I pry here to see the steps/output?
