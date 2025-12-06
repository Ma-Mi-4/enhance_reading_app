FactoryBot.define do
  factory :quiz_set do
    sequence(:title) { |n| "Vocabulary Quiz Set #{n}" }
    level { 500 }
  end
end
