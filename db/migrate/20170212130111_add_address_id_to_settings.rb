class AddAddressIdToSettings < ActiveRecord::Migration[5.0]
  def change
    add_column :settings, :address_id, :integer
    add_index :settings, :address_id
  end
end
