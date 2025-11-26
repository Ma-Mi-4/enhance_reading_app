class QuizSet < ApplicationRecord
  belongs_to :question_set
  has_many :quiz_questions, dependent: :destroy
end
