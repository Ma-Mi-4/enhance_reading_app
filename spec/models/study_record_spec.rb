require 'rails_helper'

RSpec.describe StudyRecord, type: :model do
  describe 'validations' do
    it 'user が必須であること' do
      record = build(:study_record, user: nil)
      expect(record).not_to be_valid
      expect(record.errors[:user]).to include("must exist")
    end

    it 'date が必須であること' do
      record = build(:study_record, date: nil)
      expect(record).not_to be_valid
      expect(record.errors[:date]).to include("can't be blank")
    end

    it '同じユーザーは同じ日付に2つの記録を保存できないこと' do
      user = create(:user)
      create(:study_record, user: user, date: Date.today)

      duplicate = build(:study_record, user: user, date: Date.today)
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:date]).to include("has already been taken")
    end

    it 'minutes は整数であること' do
      record = build(:study_record, minutes: "abc")
      expect(record).not_to be_valid
      expect(record.errors[:minutes]).not_to be_empty
    end

    it 'accuracy は整数であること' do
      record = build(:study_record, accuracy: "xyz")
      expect(record).not_to be_valid
      expect(record.errors[:accuracy]).not_to be_empty
    end

    it 'predicted_score は整数であること' do
      record = build(:study_record, predicted_score: "ng")
      expect(record).not_to be_valid
      expect(record.errors[:predicted_score]).not_to be_empty
    end
  end

  describe 'associations' do
    it 'user に属すること' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
