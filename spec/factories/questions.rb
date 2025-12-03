FactoryBot.define do
  factory :question do
    association :question_set

    sequence(:body) { |n| "This is a sample question body #{n}." }
    choices_text { ["Choice A", "Choice B", "Choice C", "Choice D"] }
    correct_index { 0 }
    explanation { "正解の理由の例です。" }
    wrong_explanations { ["Aが誤りの理由", "Bが誤りの理由", "Cが誤りの理由"] }
    sequence(:order) { |n| n }
  end
end
