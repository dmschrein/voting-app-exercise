class Voter < ApplicationRecord
  has_one :vote, dependent: :destroy
  has_one :candidate, through: :vote

  before_validation :normalize_email

  validates :email, presence: true, uniqueness: true,
            format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "is invalid" }
  validates :zip_code, format: { with: /\A\d{5}\z/, message: "must be 5 digits" }, allow_blank: true

  # Simple authentication: compare stored password_hash with provided password.
  def authenticate_fake_password?(password)
    self.password_hash == password
  end

  private

  def normalize_email
    self.email = email.strip.downcase if email.present?
  end
end