module Spree
  class OrderFields
    # cart fields
    JSON = %w(
      item_count items note original_total_price requires_shipping
      token total_discount total_price total_weight
    ).freeze

    METHODS = %w(
      attributes billing_address cancel_reason cancel_reason_label cancelled
      cancelled_at created_at customer customer_url discounts email
      financial_status financial_status_label fulfillment_status
      fulfillment_status_label item_count items line_items location name note
      order_number original_total_price shipping_address shipping_methods
      shipping_price subtotal_price tags tax_lines tax_price total_price
      total_weight transactions
    ).freeze

    PARAMS = %w(
    ).freeze
  end
end
