# This migration comes from solidus_liquid (originally 20170223064317)
# This migration comes from solidus_liquid (originally 20170130114818)
class CreateSolidusLiquidThemes < ActiveRecord::Migration
  def change
    create_table :solidus_liquid_themes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
