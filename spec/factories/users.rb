FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    name { "Test User" }
    level { 500 }

    password { "password" }
    password_confirmation { "password" }
  end
end
