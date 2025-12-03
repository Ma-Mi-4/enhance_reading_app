class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :study_records, dependent: :destroy
  has_many :authentications, dependent: :destroy
  has_one :notification_setting, dependent: :destroy

  # ▼ Sorcery の仕様に合わせて必ず public に置く
  def password_required?
    crypted_password.blank? && authentications.blank?
  end

  # ▼ Google login 判定（authentications があれば OAuth user）
  def google_user?
    authentications.present?
  end

  # ▼ name
  validates :name, presence: true, unless: :google_user?

  # ▼ email
  validates :email, presence: true, uniqueness: true

  # ▼ password（通常ユーザーのみ）
  validates :password,
            length: { minimum: 8 },
            confirmation: true,
            if: :password_required?

  validates :password_confirmation,
            presence: true,
            if: :password_required?

  # ▼ level
  validates :level, presence: true, unless: :google_user?
  validates :level, numericality: { only_integer: true }, unless: :google_user?
end
