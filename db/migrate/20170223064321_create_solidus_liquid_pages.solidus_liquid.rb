# This migration comes from solidus_liquid (originally 20170209055257)
class CreateSolidusLiquidPages < ActiveRecord::Migration[5.0]
  def change
    create_table :solidus_liquid_pages do |t|
      t.string :author
      t.string :name
      t.string :slug
      t.text :body_html
      t.datetime :published_at
      t.string :template_suffix

      t.timestamps
    end
    add_index :solidus_liquid_pages, :slug
  end
end
