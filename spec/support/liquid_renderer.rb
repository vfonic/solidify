Liquid::Template.error_mode = :strict

def render_liquid(template, assigns, strict = true)
  options = { filters: SolidusLiquid::LiquidHelper::LIQUID_FILTERS }
  if strict
    options[:strict_variables] = true
    options[:strict_filters] = true
  end

  liquid = ::Liquid::Template.parse(template)
  liquid.render!(assigns, options)
end
