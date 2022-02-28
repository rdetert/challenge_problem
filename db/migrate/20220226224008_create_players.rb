class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.datetime :birthdate
      t.integer :gender
      t.timestamps
    end

    add_index :players, :birthdate
    add_index :players, :gender
  end
end
