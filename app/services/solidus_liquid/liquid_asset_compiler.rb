module SolidusLiquid
  class LiquidAssetCompiler
    include AssetCompiler

    def initialize(template, settings, theme)
      super(template)
      @settings = settings
      @theme = theme
    end

    def compile
      liquid = ::Liquid::Template.parse(@template)
      assigns = { 'settings' => @settings }
      liquid.render(assigns, filters: [UrlFilters], registers: { theme: @theme })
    end
  end
end
