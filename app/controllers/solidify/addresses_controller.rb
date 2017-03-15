module Solidify
  class AddressesController < LiquidController
    def index
      render controller_action_to_liquid_file_path
    end

    def set_liquid_assigns
      @liquid_assigns = {
        'canonical_url' => "#{request.base_url}#{customer_addresses_path}",
        'page_title' => 'addresses.title',
        'template' => 'page'
      }
    end
  end
end
