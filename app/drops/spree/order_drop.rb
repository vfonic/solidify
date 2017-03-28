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

    def note
      order.special_instructions
    end

    def to_json(_json)
      { "error": 'json not allowed for this object' }.to_json
    end

    private

    def order
      @object
    end
  end
end
