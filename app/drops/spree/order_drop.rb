module Spree
  class OrderDrop < ::Liquid::Rails::Drop
    belongs_to :customer
  end
end
