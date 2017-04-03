module Spree
  LineItem.class_eval do
    def as_json(_options = {})
      Spree::LineItemDrop.new(self).as_json
    end
  end
end
