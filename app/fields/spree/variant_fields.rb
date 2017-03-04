module Spree
  class VariantFields
    JSON = %w(
      id available barcode compare_at_price featured_image inventory_management
      inventory_policy inventory_quantity name option1 option2 option3 options
      price public_title requires_shipping sku taxable title weight
    ).freeze

    METHODS = %w(
      id available barcode compare_at_price image incoming inventory_management
      inventory_policy inventory_quantity next_incoming_date option1 option2
      option3 price requires_shipping selected sku taxable title url weight
      weight_unit weight_in_unit
    ).freeze

    PARAMS = %w(
    ).freeze
  end
end
