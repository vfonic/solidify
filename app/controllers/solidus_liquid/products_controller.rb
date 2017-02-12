module SolidusLiquid
  class ProductsController < LiquidController
    include ::Spree::Core::ControllerHelpers::Auth
    include ::Spree::Core::ControllerHelpers::Pricing
    include ::Spree::Core::ControllerHelpers::Store

    before_action :load_collection
    rescue_from ActiveRecord::RecordNotFound, with: :render_404_page

    def show
      @variants = product.
        variants_including_master.
        display_includes.
        with_prices(current_pricing_options).
        includes([:option_values, :images])

      @product_properties = product.product_properties.includes(:property)
      @taxon = Spree::Taxon.find(params[:taxon_id]) if params[:taxon_id]

      render controller_action_to_liquid_file_path(product)
    end

    def set_liquid_assigns
      @liquid_assigns = {
        'canonical_url' => "#{request.base_url}#{product.url}",
        'collection' => @collection,
        'page_title' => product.title,
        'product' => product,
        'template' => 'product'
      }
    end

    private

    def product
      @product ||= Spree::Product.available.friendly.find(params[:id])
    end

    def load_collection
      @collection = Spree::Taxon.where(handle: params[:taxon_id]).first
    end
  end
end
