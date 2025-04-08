class Vote < ApplicationRecord
  belongs_to :voter
  belongs_to :candidate

  def self.votes_by_candidate
    joins(:candidate).group('candidates.name').order('count_all desc').count
  end

  
end
