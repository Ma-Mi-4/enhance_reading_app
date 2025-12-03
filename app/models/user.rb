class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :study_records, dependent: :destroy
  has_many :authentications, dependent: :destroy
  has_one :notification_setting, dependent: :destroy

  # OAuth ログイン時はパスワード不要
  def password_required?
    crypted_password.blank? && authentications.blank?
  end

  # 通常登録時のみ name 必須
  validates :name, presence: true, on: :update

  validates :email, presence: true, uniqueness: true
  validates :reset_password_token, uniqueness: true, allow_nil: true

  validates :password, length: { minimum: 8 }, if: :password_required?
  validates :password, confirmation: true, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?
end
