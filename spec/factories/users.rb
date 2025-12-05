FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    name { "Test User" }
    level { 500 }

    transient do
      raw_password { "password" }
    end

    # Sorcery の password= を build 時点で呼ぶ必要がある！
    after(:build) do |user, evaluator|
      user.password = evaluator.raw_password
      user.password_confirmation = evaluator.raw_password
    end
  end
end
