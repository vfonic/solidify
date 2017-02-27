# This migration comes from solidus_liquid (originally 20170223064318)
# This migration comes from solidus_liquid (originally 20170206094936)
class CreateSolidusLiquidLinkLists < ActiveRecord::Migration[5.0]
  def change
    create_table :solidus_liquid_link_lists do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
    add_index :solidus_liquid_link_lists, :slug
  end
end
