module Solidify
  module Liquid
    extend ActiveSupport::Concern

    included do
      include LiquidHelper
      include ShopHelper
      prepend_before_action :set_active_theme
      before_action :set_liquid_assigns

      layout :theme_layout_file

      def liquid_assigns
        # merge example:
        # { nested: { one: 1 } }.merge({ nested: { two: 2 } })
        # => { nested: { two: 2 } }
        # deep_merge example:
        # { nested: { one: 1 } }.merge({ nested: { two: 2 } })
        # => { nested: { one: 1, two: 2 } }
        super.merge(@liquid_assigns)
      end

      alias_method :customer, :current_customer
    end
  end
end
