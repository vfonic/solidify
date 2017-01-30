class CreateLiquorThemes < ActiveRecord::Migration
  def change
    create_table :liquor_themes do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
