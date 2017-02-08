class CreateSolidusLiquidSettings < ActiveRecord::Migration
  def self.up
    create_table :solidus_liquid_settings do |t|
      t.string  :var,        null: false
      t.text    :value,      null: true
      t.integer :thing_id,   null: true
      t.string  :thing_type, null: true, limit: 30
      t.timestamps
    end

    add_index :solidus_liquid_settings,
              %i(thing_type thing_id var),
              unique: true,
              name: 'index_solidus_liquid_settings_on_thing_and_var'
  end

  def self.down
    drop_table :solidus_liquid_settings
  end
end
