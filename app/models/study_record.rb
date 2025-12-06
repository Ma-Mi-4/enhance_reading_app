class StudyRecord < ApplicationRecord
  belongs_to :user

  validates :date, presence: true, uniqueness: { scope: :user_id }

  validates :minutes, numericality: { only_integer: true }
  validates :accuracy, numericality: { only_integer: true }
  validates :predicted_score, numericality: { only_integer: true }
end
