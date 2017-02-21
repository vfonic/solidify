module SolidusLiquid
  module InventoryPolicy
    extend ActiveSupport::Concern
    INVENTORY_POLICY_DENY = "deny"
    INVENTORY_POLICY_ALLOW = "continue"
  end
end
