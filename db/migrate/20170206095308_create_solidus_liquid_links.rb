class CreateSolidusLiquidLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :solidus_liquid_links do |t|
      t.string :title
      t.string :url
      t.integer :link_list_id

      t.timestamps
    end
    add_index :solidus_liquid_links, :link_list_id
  end
end
