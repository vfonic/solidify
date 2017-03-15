module Solidify
  class CustomersController < LiquidController
    def show
      render controller_action_to_liquid_file_path(customer)
    end

    def set_liquid_assigns
      @liquid_assigns = {
        'canonical_url' => "#{request.base_url}/account",
        'customer' => customer,
        'page_title' => 'customer.title',
        'template' => 'customer'
      }
    end
  end
end
