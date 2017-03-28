module Solidify
  class RegistrationsController < ::Devise::RegistrationsController
    include Solidify::Liquid

    self.responder = Solidify::LiquidResponder

    # rubocop:disable Metrics/LineLength
    def set_liquid_assigns
      @liquid_assigns = {
        'canonical_url' => "#{request.base_url}#{new_customer_registration_path}",
        'page_title' => 'Create Account',
        'template' => 'page'
      }
    end

    before_action :configure_sign_up_params, only: [:create]

    protected

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up,
                                        keys: %i(first_name last_name))
    end
  end
end
