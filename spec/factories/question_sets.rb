FactoryBot.define do
  factory :question_set do
    title { "Test Question Set" }
    level { 500 }

    trait :with_questions do
      transient do
        questions_count { 3 }
      end

      after(:create) do |question_set, evaluator|
        create_list(:question, evaluator.questions_count, question_set: question_set)
      end
    end
  end
end
