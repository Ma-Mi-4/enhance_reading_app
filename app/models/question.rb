class Question < ApplicationRecord
  belongs_to :question_set

  validates :body, presence: true
  validates :order, presence: true

  validates :choices_text, presence: true
  validate :choices_text_must_be_array

  validates :wrong_explanations, presence: true
  validate :wrong_explanations_must_be_array

  validates :correct_index,
            presence: true,
            numericality: { only_integer: true }
  validate :correct_index_within_choices
  

  private

  def choices_text_must_be_array
    errors.add(:choices_text, "must be an array") unless choices_text.is_a?(Array)
  end

  def wrong_explanations_must_be_array
    errors.add(:wrong_explanations, "must be an array") unless wrong_explanations.is_a?(Array)
  end

  def correct_index_within_choices
    return unless correct_index.is_a?(Integer)
    return if choices_text.is_a?(Array) && correct_index < choices_text.length

    errors.add(:correct_index, "is out of range")
  end
end
