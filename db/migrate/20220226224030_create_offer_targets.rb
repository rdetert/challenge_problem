class CreateOfferTargets < ActiveRecord::Migration[7.0]
  def change
    create_table :offer_targets do |t|
      t.belongs_to :offer
      t.integer :min_age
      t.integer :max_age
      t.integer :gender
      t.integer :os
      t.string :min_os_version, collation: 'en_natural'
      t.integer :locale
      t.timestamps
    end
    
    add_index :offer_targets, :min_age
    add_index :offer_targets, :max_age
    add_index :offer_targets, :gender
    add_index :offer_targets, :min_os_version
    add_index :offer_targets, :locale
  end
end
