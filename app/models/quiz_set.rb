class QuizSet < ApplicationRecord
  belongs_to :question_set, optional: true 
  has_many :quiz_questions, dependent: :destroy

  validates :title, presence: true
  validates :level, presence: true
  validates :level, numericality: { only_integer: true }
end
