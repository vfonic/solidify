# This migration comes from solidify (originally 20170208021602)
class CreateSolidifySettings < ActiveRecord::Migration[5.0]
  def self.up
    # create_table :solidify_settings do |t|
    create_table :settings do |t|
      t.string  :var,        null: false
      t.text    :value,      null: true
      t.integer :thing_id,   null: true
      t.string  :thing_type, null: true, limit: 30
      t.timestamps
    end

    add_index :settings,
              %i(thing_type thing_id var),
              unique: true,
              name: 'index_settings_on_thing_and_var'
  end

  def self.down
    drop_table :settings
  end
end
