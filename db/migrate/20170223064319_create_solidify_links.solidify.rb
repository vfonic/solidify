# This migration comes from solidify (originally 20170206095308)
class CreateSolidifyLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :solidify_links do |t|
      t.string :name
      t.string :url
      t.integer :link_list_id

      t.timestamps
    end
    add_index :solidify_links, :link_list_id
  end
end
