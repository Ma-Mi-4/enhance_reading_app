require 'rails_helper'

RSpec.describe QuizSet, type: :model do
  describe 'validations' do
    it 'title が必須であること' do
      qs = build(:quiz_set, title: nil)
      expect(qs).not_to be_valid
      expect(qs.errors[:title]).to include("can't be blank")
    end

    it 'level が必須であること' do
      qs = build(:quiz_set, level: nil)
      expect(qs).not_to be_valid
      expect(qs.errors[:level]).to include("can't be blank")
    end

    it 'level が整数であること' do
      qs = build(:quiz_set, level: "abc")
      expect(qs).not_to be_valid
      expect(qs.errors[:level]).not_to be_empty
    end
  end

  describe 'associations' do
    it 'question_set に属すること' do
      assoc = described_class.reflect_on_association(:question_set)
      expect(assoc.macro).to eq(:belongs_to)
    end

    it '複数の quiz_questions を持つこと' do
      assoc = described_class.reflect_on_association(:quiz_questions)
      expect(assoc.macro).to eq(:has_many)
    end
  end
end
