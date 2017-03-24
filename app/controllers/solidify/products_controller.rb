module Solidify
  class ProductsController < LiquidController
    def show
      render controller_action_to_liquid_file_path(product)
    end

    # rubocop:disable Metrics/AbcSize
    def set_liquid_assigns
      if params[:variant_id].present?
        product.selected_variant = ::Spree::Variant.find(params[:variant_id])
      end

      @liquid_assigns = {
        'canonical_url' => "#{request.base_url}#{product.url}",
        'collection' => collection,
        'page_title' => product.title,
        'product' => product,
        'template' => 'product'
      }
    end
    # rubocop:enable Metrics/AbcSize

    private

    def product
      @product ||= ::Spree::Product.available.find(params[:id])
    end

    def collection
      return unless params[:collection_id].present?
      @collection ||= ::Spree::Taxon.where(handle: params[:collection_id]).first
    end
  end
end
