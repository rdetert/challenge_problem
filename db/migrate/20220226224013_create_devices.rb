class CreateDevices < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL.chomp
      CREATE COLLATION IF NOT EXISTS en_natural (
        LOCALE = 'en-US-u-kn-true',
        PROVIDER = 'icu'
      );
    SQL

    create_table :devices do |t|
      t.references :player
      t.string :device_model
      t.integer :os
      t.string :os_version, collation: 'en_natural'
      t.integer :locale
      t.timestamps
    end

    add_index :devices, :device_model
    add_index :devices, :os
    add_index :devices, :os_version
    add_index :devices, :locale
  end

  def down
    drop_table :devices
  end
end
