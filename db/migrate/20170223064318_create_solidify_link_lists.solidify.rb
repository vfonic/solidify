# This migration comes from solidify (originally 20170206094936)
class CreateSolidifyLinkLists < ActiveRecord::Migration[5.0]
  def change
    create_table :solidify_link_lists do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
    add_index :solidify_link_lists, :slug
  end
end
