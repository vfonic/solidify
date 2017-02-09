module SolidusLiquid
  class PagesController < LiquidController
    def show
      render controller_action_to_liquid_file_path(page)
    end

    def set_liquid_assigns
      @liquid_assigns = {
        'canonical_url' => "#{request.base_url}#{page.url}",
        'page' => page,
        'page_title' => page.title,
        'template' => 'page'
      }
    end

    private

    def page
      @page ||= Page.find(params[:id])
    end
  end
end
