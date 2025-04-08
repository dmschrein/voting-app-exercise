class AddNullConstraints < ActiveRecord::Migration[7.0]
  # NOTE: Handle existing data where columns are null in live system.
  def up
    change_column_null :voters, :email, false
    change_column_null :candidates, :name, false
    change_column_null :votes, :voter_id, false
    change_column_null :votes, :candidate_id, false
  end

  def down
    # We deliberately do not remove these constraints on rollback.
  end
end
