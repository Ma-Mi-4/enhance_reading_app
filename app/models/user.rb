class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :study_records, dependent: :destroy
  has_many :authentications, dependent: :destroy
  has_one :notification_setting, dependent: :destroy

  # OAuth ログイン時はパスワード不要
  def password_required?
    # crypted_password がない かつ 既存認証(authentications)がない場合のみ必要
    crypted_password.blank? && authentications.blank?
  end

  # 名前がない Google アカウントも存在するので任意にする
  validates :name, presence: true, unless: -> { authentications.present? }

  validates :email, presence: true, uniqueness: true
  validates :reset_password_token, uniqueness: true, allow_nil: true

  validates :password, length: { minimum: 8 }, if: :password_required?
  validates :password, confirmation: true, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?
end
