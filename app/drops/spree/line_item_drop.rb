module Spree
  class LineItemDrop < ::Liquid::Rails::Drop
    has_one :id, :product, :quantity, :url
  end
end
