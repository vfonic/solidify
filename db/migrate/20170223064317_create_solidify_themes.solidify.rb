# This migration comes from solidify (originally 20170130114818)
class CreateSolidifyThemes < ActiveRecord::Migration[5.0]
  def change
    create_table :solidify_themes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
