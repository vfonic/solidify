module Spree
  class LineItemFields
    JSON = %w(
      id discounted_price discounts gift_card grams handle image key line_price
      original_line_price original_price price product_description product_id
      product_title product_type properties quantity requires_shipping sku title
      total_discount url variant_id variant_options variant_title vendor
    ).freeze

    METHODS = %w(
      id discounts fulfillment fulfillment_service gift_card grams image key
      line_price message original_line_price original_price price product
      product_id properties quantity requires_shipping sku
      successfully_fulfilled_quantity taxable title total_discount url variant
      variant_id vendor
    ).freeze

    PARAMS = %w(
    ).freeze
  end
end
