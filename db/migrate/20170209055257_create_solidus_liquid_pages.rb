class CreateSolidusLiquidPages < ActiveRecord::Migration[5.0]
  def change
    create_table :solidus_liquid_pages do |t|
      t.string :author
      t.string :title
      t.string :handle
      t.text :body_html
      t.datetime :published_at
      t.string :template_suffix

      t.timestamps
    end
    add_index :solidus_liquid_pages, :handle
  end
end
