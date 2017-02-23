module SolidusLiquid
  class OrdersController < LiquidController
    # Adds a new item to the order (creating a new order if none already exists)
    def populate
      order = current_order(create_order_if_necessary: true)
      variant  = Spree::Variant.find(params[:id])
      quantity = params[:quantity].present? ? params[:quantity].to_i : 1

      order.contents.add(variant, quantity)

      redirect_to cart_path
    end

    def set_liquid_assigns
      @liquid_assigns = {}
    end
  end
end
