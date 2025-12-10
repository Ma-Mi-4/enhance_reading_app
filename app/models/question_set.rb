class QuestionSet < ApplicationRecord
  has_many :questions, dependent: :destroy

  validates :title, presence: true
  validates :level, presence: true, numericality: { only_integer: true }
end
