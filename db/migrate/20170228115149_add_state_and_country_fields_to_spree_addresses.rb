class AddStateAndCountryFieldsToSpreeAddresses < ActiveRecord::Migration[5.0]
  def change
    add_column :spree_addresses, :state_code, :string
    add_column :spree_addresses, :country_name, :string
    add_column :spree_addresses, :country_code, :string
  end
end
