FactoryBot.define do
  factory :admin_user do
    name { "Admin User" }
    email { Faker::Internet.unique.email }
    password { "password" }
    password_confirmation { "password" }
    admin { true }
  end
end
