module SolidusLiquid
  class CollectionsController < LiquidController
    def show
      render controller_action_to_liquid_file_path(collection)
    end

    def set_liquid_assigns
      @liquid_assigns = {
        'canonical_url' => "#{request.base_url}#{collection.url}",
        'collection' => collection,
        'page_title' => collection.title,
        'template' => 'collection'
      }
    end

    private

    def collection
      @collection ||= Spree::Taxon.where(handle: params[:id]).first_or_initialize
    end
  end
end
