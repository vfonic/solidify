module SolidusLiquid
  class SessionsController < ::Devise::SessionsController
    include ::SolidusLiquid::Liquid

    def set_liquid_assigns
      @liquid_assigns = {
        'canonical_url' => "#{request.base_url}#{new_customer_session_path}",
        # 'canonical_url' => "#{request.base_url}#{new_spree_user_session_path}",
        # 'form' => @form,
        'page_title' => 'Log in',
        'template' => 'page'
      }
    end
  end
end
