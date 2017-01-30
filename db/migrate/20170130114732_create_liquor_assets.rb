class CreateLiquorAssets < ActiveRecord::Migration
  def change
    create_table :liquor_assets do |t|
      t.integer :theme_id
      t.string :key
      t.string :file

      t.timestamps null: false
    end
    add_index :liquor_assets, :theme_id
    add_index :liquor_assets, :key
  end
end
