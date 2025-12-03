FactoryBot.define do
  factory :study_record do
    association :user

    date { Date.today }
    minutes { 10 }
    accuracy { 80 }
    predicted_score { 650 }
  end
end
