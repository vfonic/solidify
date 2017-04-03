module Spree
  class OrderDrop < ::Liquid::Rails::Drop
    attributes(*OrderFields::JSON)

    delegate :billing_address, :shipping_address, :created_at, to: :order

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

    def requires_shipping
      true
    end

    def subtotal_price
      order.item_total - order.adjustment_total
    end

    def total_discount
      0
    end

    def total_price
      order.total.to_money.cents
    end
    alias original_total_price total_price

    def total_weight
      0
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
