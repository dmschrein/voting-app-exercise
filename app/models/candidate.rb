class Candidate < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes

  MAX_CANDIDATES = 10

  validates :name, presence: true, uniqueness: true
  validate :validate_candidate_count, on: :create

  private

  def validate_candidate_count
    if Candidate.count >= MAX_CANDIDATES
      errors.add(:base, "Maximum number of #{MAX_CANDIDATES} candidates exceeded.")
    end
  end
end