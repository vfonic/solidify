# This migration comes from solidus_liquid (originally 20170223064322)
# This migration comes from solidus_liquid (originally 20170209103022)
class AddAttributesToSpreeUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :spree_users, :first_name, :string
    add_column :spree_users, :last_name, :string
  end
end
