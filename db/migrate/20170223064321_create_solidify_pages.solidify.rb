# This migration comes from solidify (originally 20170209055257)
class CreateSolidifyPages < ActiveRecord::Migration[5.0]
  def change
    create_table :solidify_pages do |t|
      t.string :author
      t.string :name
      t.string :slug
      t.text :body_html
      t.datetime :published_at
      t.string :template_suffix

      t.timestamps
    end
    add_index :solidify_pages, :slug
  end
end
