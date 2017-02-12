class AddHandleToSpreeProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :spree_products, :handle, :string
    add_index :spree_products, :handle
  end
end
