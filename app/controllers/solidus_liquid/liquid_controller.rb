module SolidusLiquid
  class LiquidController < ApplicationController
    include SolidusLiquid::Liquid

    def set_liquid_assigns
      raise 'Need to call this from subclass'
    end

    def render_404_page(_exception = nil)
      render status: :not_found, template: controller_action_to_liquid_file_path(nil, 'home#missing'), formats: [:html], layout: theme_layout_file
    end
  end
end
