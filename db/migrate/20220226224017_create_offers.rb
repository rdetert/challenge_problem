class CreateOffers < ActiveRecord::Migration[7.0]
  def change
    create_table :offers do |t|
      t.string :title
      t.string :header
      t.text :description
      t.integer :points
      t.decimal :payout, :precision => 8, :scale => 2
      t.timestamps
    end
  end
end
