module SolidusLiquid
  class HomeController < LiquidController
    def index
      render controller_action_to_liquid_file_path
    end

    def set_liquid_assigns
      @liquid_assigns = {
        'canonical_url' => request.base_url.to_s,
        'page_title' => '',
        'template' => 'page'
      }
    end
  end
end
