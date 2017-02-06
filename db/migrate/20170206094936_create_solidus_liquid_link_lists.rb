class CreateSolidusLiquidLinkLists < ActiveRecord::Migration[5.0]
  def change
    create_table :solidus_liquid_link_lists do |t|
      t.string :title
      t.string :handle

      t.timestamps
    end
    add_index :solidus_liquid_link_lists, :handle
  end
end
