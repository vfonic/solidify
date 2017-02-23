module SolidusLiquid
  class SearchController < LiquidController
    def index
      render controller_action_to_liquid_file_path
    end

    def set_liquid_assigns
      @liquid_assigns = {
        'canonical_url' => "#{request.base_url}#{search_path}",
        'page_title' => '',
        'search' => search,
        'template' => 'page'
      }
    end

    private

    def search
      return @search if @search.present?

      @search = if params[:q].blank?
                  Search.new
                else
                  perform_search
                end
    end

    def perform_search
      product_scope = Spree::Product.accessible_by(
        Spree::Ability.new(current_spree_user), :read
      )
      search_result = product_scope.ransack(params[:q]).result
      Search.new(
        true,
        search_result,
        search_result.count,
        params[:q]
      )
    end
  end
end
