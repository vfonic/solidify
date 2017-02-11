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

      if params[:q].blank?
        @search = Search.new
      else
        @search = perform_search
      end
    end

    def perform_search
      product_scope = Spree::Product.accessible_by(Spree::Ability.new(current_spree_user), :read)
      Search.new(
        true,
        product_scope.ransack(params[:q]).result,
        product_scope.ransack(params[:q]).result.count,
        params[:q]
      )
    end
  end
end
