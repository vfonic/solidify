STRICT_OPTIONS = { filters: SolidusLiquid::LiquidHelper::LIQUID_FILTERS,
                   strict_variables: true,
                   strict_filters: true }.freeze
LAX_OPTIONS = { filters: SolidusLiquid::LiquidHelper::LIQUID_FILTERS,
                strict_variables: false,
                strict_filters: false }.freeze

def render_liquid(template, assigns, strict = true)
  if strict
    Liquid::Template.error_mode = :strict
    options = STRICT_OPTIONS
    render_method = :render!
  else
    Liquid::Template.error_mode = :lax
    options = LAX_OPTIONS
    render_method = :render
  end

  Liquid::Template.parse(template).public_send(render_method, assigns, options)
end
