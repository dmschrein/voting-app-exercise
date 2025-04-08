class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.references :voter, null: false, foreign_key: true, index: {unique: true}
      t.references :candidate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
