module Solidify
  module InventoryPolicy
    extend ActiveSupport::Concern
    INVENTORY_POLICY_DENY = 'deny'.freeze
    INVENTORY_POLICY_ALLOW = 'continue'.freeze
  end
end
