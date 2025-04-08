class CreateCandidates < ActiveRecord::Migration[7.0]
  def change
    create_table :candidates do |t|
      t.integer :votes, default: 0
      t.string :name
      t.timestamps
    end

    add_index :candidates, :name, unique: true
  end
end
