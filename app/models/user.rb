class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :study_records, dependent: :destroy
  has_many :authentications, dependent: :destroy
  has_one :notification_setting, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :reset_password_token, uniqueness: true, allow_nil: true

  def password_required?
    authentications.blank? && (new_record? || changes[:crypted_password])
  end

  validates :password, length: { minimum: 8 }, if: :password_required?
  validates :password, confirmation: true, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?
end
