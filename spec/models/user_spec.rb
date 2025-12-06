require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it '名前が必須であること' do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'メールアドレスが必須であること' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'メールアドレスがユニークであること' do
      create(:user, email: "test@example.com")
      user = build(:user, email: "test@example.com")

      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("has already been taken")
    end

    it 'パスワードが必須であること（Sorcery）' do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
      expect(user.errors[:password]).not_to be_empty
    end

    it 'level が必須であること' do
      user = build(:user, level: nil)
      expect(user).not_to be_valid
      expect(user.errors[:level]).to include("can't be blank")
    end

    it 'level が整数であること' do
      user = build(:user, level: "abc")
      expect(user).not_to be_valid
      expect(user.errors[:level]).not_to be_empty
    end
  end

  describe 'associations' do
    it '複数の study_records を持つこと' do
      assoc = described_class.reflect_on_association(:study_records)
      expect(assoc.macro).to eq(:has_many)
    end
  end
end
