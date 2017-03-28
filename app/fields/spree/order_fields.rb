module Spree
  class OrderFields
    # cart fields
    JSON = %w(
      attributes item_count items note original_total_price requires_shipping
      token total_discount total_price total_weight
    ).freeze

    METHODS = %w(
      billing_address cancelled cancelled_at cancel_reason cancel_reason_label
      created_at customer customer_url discounts email financial_status
      financial_status_label fulfillment_status fulfillment_status_label
      line_items location name note order_number shipping_address
      shipping_methods shipping_price subtotal_price tax_lines tax_price
      total_price transactions tags
    ).freeze

    PARAMS = %w(
    ).freeze
  end
end
