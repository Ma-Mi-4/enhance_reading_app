class QuestionSet < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_one :quiz_set, dependent: :destroy
end
