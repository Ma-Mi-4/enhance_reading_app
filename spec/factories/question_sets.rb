FactoryBot.define do
  factory :question_set do
    sequence(:title) { |n| "Part7 Level#{level}_#{n}" }
    level { 500 }
  end
end
