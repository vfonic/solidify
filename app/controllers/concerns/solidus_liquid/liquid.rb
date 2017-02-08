module SolidusLiquid
  module Liquid
    extend ActiveSupport::Concern

    included do
      self.responder = SolidusLiquid::LiquidResponder

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
    end
  end
end
