class CreateVoters < ActiveRecord::Migration[7.0]
  def change
    create_table :voters do |t|
      t.string :name
      t.string :email
      t.string :password_hash
      t.integer :zip_code
      t.timestamps
    end

    add_index :voters, :email, unique: true
  end
end
