module Spree
  class OrderDrop < ::Liquid::Rails::Drop
    attributes :item_count, :total

    belongs_to :customer

    def attributes
      {}
    end

    # TODO: make sure solidus total shows the same as shopfiy's total_price
    alias total_price total
  end
end
