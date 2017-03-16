module Solidify
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
      @collection ||= if params[:id] == 'all'
                        Spree::Taxon.find_or_create_collections_all
                      else
                        Spree::Taxon.find(params[:id])
                      end
    end
  end
end
