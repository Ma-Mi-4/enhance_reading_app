require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'validations' do
    it 'body が必須であること' do
      q = build(:question, body: nil)
      expect(q).not_to be_valid
      expect(q.errors[:body]).to include("can't be blank")
    end

    it 'choices_text が配列であること' do
      q = build(:question, choices_text: "not-an-array")
      expect(q).not_to be_valid
      expect(q.errors[:choices_text]).not_to be_empty
    end

    it 'correct_index が整数であること' do
      q = build(:question, correct_index: "abc")
      expect(q).not_to be_valid
      expect(q.errors[:correct_index]).not_to be_empty
    end

    it 'correct_index が choices_text 内の有効範囲に含まれること' do
      q = build(:question, correct_index: 10)
      expect(q).not_to be_valid
      expect(q.errors[:correct_index]).not_to be_empty
    end

    it 'order が必須であること' do
      q = build(:question, order: nil)
      expect(q).not_to be_valid
      expect(q.errors[:order]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it 'question_set に属すること' do
      association = described_class.reflect_on_association(:question_set)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
