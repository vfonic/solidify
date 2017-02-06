class CreateSolidusLiquidThemes < ActiveRecord::Migration
  def change
    create_table :solidus_liquid_themes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
