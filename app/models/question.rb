class Question < ApplicationRecord
  has_many :choices, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true
  validates :level, presence: true
  validates :category, presence: true
  validates :word_count, presence: true
end
