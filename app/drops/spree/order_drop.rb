module Spree
  class OrderDrop < ::Liquid::Rails::Drop
    attributes :billing_address, :shipping_address, :created_at

    delegate :number, to: :order, prefix: true
    alias name order_number

    def cancelled
      order.canceled?
    end

    def cancelled_at
      order.canceled_at
    end

    def customer_url
      "#{view.request.base_url}#{view.customer_order_path(order.number)}"
    end

    delegate :email, to: :order

    delegate :item_count, to: :order

    delegate :line_items, to: :order
    alias items line_items

    def note
      order.special_instructions
    end

    def subtotal_price
      order.item_total - order.adjustment_total
    end

    def total_price
      order.total.to_money.cents
    end

    def to_json(_json)
      { "error": 'json not allowed for this object' }.to_json
    end

    private

    def order
      @object
    end

    def view
      @context.registers[:view]
    end
  end
end
