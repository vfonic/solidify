Liquid::Template.error_mode = :strict

def render_liquid(template:, assigns: nil)
  liquid = ::Liquid::Template.parse(template)
  liquid.render!(
    assigns,
    filters: SolidusLiquid::LiquidHelper::LIQUID_FILTERS,
    strict_variables: true,
    strict_filters: true
  )
end
