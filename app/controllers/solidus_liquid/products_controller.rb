module SolidusLiquid
  class ProductsController < LiquidController
    before_action :load_collection

    def show
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
      return unless params[:taxon_id].present?
      @collection ||= Spree::Taxon.where(handle: params[:taxon_id]).first
    end
  end
end
