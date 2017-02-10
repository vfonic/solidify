module SolidusLiquid
  class SessionsController < ::Devise::SessionsController
    include SolidusLiquid::Liquid

    def set_liquid_assigns
      @liquid_assigns = {
        'page_title' => 'Log in'
      }
    end

    def new
      render controller_action_to_liquid_file_path
    end
  end
end
