class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :study_records, dependent: :destroy
  has_many :authentications, dependent: :destroy
  has_one :notification_setting, dependent: :destroy

  def password_required?
    new_record? && crypted_password.blank? && authentications.blank?
  end

  def google_user?
    authentications.present?
  end

  # name
  validates :name, presence: true, unless: :google_user?

  # email
  validates :email, presence: true, uniqueness: true

  # password
  validates :password,
            length: { minimum: 8 },
            confirmation: true,
            if: :password_required?
  validates :password_confirmation,
            presence: true,
            if: :password_required?

  # level → update の時だけチェック（Google ユーザーは除外）
  validates :level,
            presence: true,
            numericality: { only_integer: true },
            unless: :google_user?,
            on: :update
end
