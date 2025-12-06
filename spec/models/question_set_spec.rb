require 'rails_helper'

RSpec.describe QuestionSet, type: :model do
  describe 'validations' do
    it 'title が必須であること' do
      qs = build(:question_set, title: nil)
      expect(qs).not_to be_valid
      expect(qs.errors[:title]).to include("can't be blank")
    end

    it 'level が必須であること' do
      qs = build(:question_set, level: nil)
      expect(qs).not_to be_valid
      expect(qs.errors[:level]).to include("can't be blank")
    end

    it 'level が整数であること' do
      qs = build(:question_set, level: "abc")
      expect(qs).not_to be_valid
      expect(qs.errors[:level]).not_to be_empty
    end
  end

  describe 'associations' do
    it '複数の questions を持つこと' do
      association = described_class.reflect_on_association(:questions)
      expect(association.macro).to eq(:has_many)
    end
  end
end
