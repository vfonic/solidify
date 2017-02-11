module SolidusLiquid
  class SessionsController < ::Devise::SessionsController
    include SolidusLiquid::Liquid

    self.responder = SolidusLiquid::LiquidResponder

    def set_liquid_assigns
      @liquid_assigns = {
        'canonical_url' => "#{request.base_url}#{new_customer_session_path}",
        'page_title' => 'Log in',
        'template' => 'page'
      }
    end
  end
end
