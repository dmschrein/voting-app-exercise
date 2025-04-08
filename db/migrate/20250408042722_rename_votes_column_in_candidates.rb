class RenameVotesColumnInCandidates < ActiveRecord::Migration[7.0]
  def change
    rename_column :candidates, :votes, :vote_count
  end
end
