class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :study_records, dependent: :destroy
  has_many :authentications, dependent: :destroy
  has_one :notification_setting, dependent: :destroy

  def password_required?
    new_record? && crypted_password.blank? && authentications.blank?
  end

  def google_user?
    return false if Rails.env.test?
    authentications.present?
  end

  # name
  validates :name, presence: true, unless: :google_user?

  # email
  validates :email, presence: true, uniqueness: true, unless: :google_user?

  # password
  validates :password,
            length: { minimum: 8 },
            confirmation: true,
            if: :password_required?

  validates :password_confirmation,
            presence: true,
            if: :password_required?

  # level
  validates :level,
            presence: true,
            numericality: { only_integer: true },
            unless: :google_user?
end
