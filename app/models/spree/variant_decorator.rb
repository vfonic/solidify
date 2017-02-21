module Spree
  Variant.class_eval do
    include SolidusLiquid::InventoryPolicy
    # Returns true if the variant is available for purchase, or false if it not.
    # For a variant to be available, its variant.inventory_quantity must be
    # greater than zero or variant.inventory_policy must be set to continue. A
    # variant with no variant.inventory_management is also considered available.
    def available
      true
      # inventory_management.blank? || inventory_policy == INVENTORY_POLICY_ALLOW || inventory_quantity(??? check VariantDrop) > 0
    end
  end
end
