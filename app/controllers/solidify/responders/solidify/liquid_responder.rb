module Solidify
  class LiquidResponder < ::ActionController::Responder
    DEFAULT_ACTIONS_FOR_VERBS = {
      post: :new, patch: :edit, put: :edit, get: :new
    }.freeze

    include LiquidHelper

    def to_html
      liquid_assigns = controller.instance_variable_get(:@liquid_assigns)
      liquid_assigns['form'] = resource

      if options[:location].present?
        redirect_to(options[:location])
      else
        render_liquid_from_controller_action
      end
    end

    private

    def render_liquid_from_controller_action
      controller_name = controller.controller_name
      action_name = DEFAULT_ACTIONS_FOR_VERBS[request.request_method_symbol]
      controller_action = "#{controller_name}##{action_name}"
      render controller_action_to_liquid_file_path(resource, controller_action)
    end
  end
end
