# This migration comes from solidus_liquid (originally 20170223064319)
# This migration comes from solidus_liquid (originally 20170206095308)
class CreateSolidusLiquidLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :solidus_liquid_links do |t|
      t.string :name
      t.string :url
      t.integer :link_list_id

      t.timestamps
    end
    add_index :solidus_liquid_links, :link_list_id
  end
end
