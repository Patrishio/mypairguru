FactoryBot.define do
  factory :user do    
    name                   { Faker::Name.name }
    email                  { Faker::Internet.email }
    password               "password"
    password_confirmation  "password"    
    confirmed_at           Time.zone.now
    
    factory :enhanced_user do      
    end

    factory :normal_user do
      after(:create) do |usser|
        usser.enhanced = false
      end
    end
    
  end
end
