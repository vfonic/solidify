# This migration comes from solidify (originally 20170130114732)
class CreateSolidifyAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :solidify_assets do |t|
      t.integer :theme_id
      t.string :key
      t.string :file

      t.timestamps null: false
    end
    add_index :solidify_assets, :theme_id
    add_index :solidify_assets, :key
  end
end
