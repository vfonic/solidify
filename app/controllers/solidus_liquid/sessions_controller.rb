module SolidusLiquid
  class SessionsController < ::Devise::SessionsController
    include SolidusLiquid::Liquid

    def set_liquid_assigns
      @liquid_assigns = {
        'canonical_url' => "#{request.base_url}#{new_customer_session_path}",
        'page_title' => 'Log in',
        'template' => 'page'
      }
    end

    def new
      render controller_action_to_liquid_file_path
    end
  end
end
