class AddHandleToSpreeTaxons < ActiveRecord::Migration[5.0]
  def change
    add_column :spree_taxons, :handle, :string
    add_index :spree_taxons, :handle
  end
end
