module Liquor
  class AssetPostprocessor
    def initialize(asset)
      @asset = asset
    end

    def process
      process_for_key(
        asset: @asset,
        key: @asset.key,
        template: File.read(@asset.file.path),
        settings: @asset.theme.settings
      )
    end

    private

    def process_for_key(asset:, key:, template:, settings:)
      return unless key.start_with?('assets/')
      if key.end_with?('.liquid')
        process_liquid(asset: asset, key: key.gsub(/.liquid$/, ''),
                       template: template, settings: settings)
      elsif key.end_with?('.scss')
        process_scss(asset: asset, key: key, template: template)
      end
    end

    def process_liquid(asset:, key:, template:, settings:)
      rendered_liquid = LiquidAssetCompiler.new(template, settings,
                                                asset.theme).compile
      if key.end_with?('.scss')
        process_scss(asset: asset, key: key, template: rendered_liquid)
      else
        new_asset = Asset.where(key: key, theme: asset.theme).first_or_initialize
        new_asset.update_attributes(
          file: AppSpecificStringIO.new(key, rendered_liquid)
        )
      end
    end

    def process_scss(asset:, key:, template:)
      rendered_css = ScssAssetCompiler.new(template).compile
      new_asset = Asset.where(key: "#{key}.css",
                              theme: asset.theme).first_or_initialize
      new_asset.update_attributes(
        file: AppSpecificStringIO.new("#{key}.css", rendered_css)
      )
    end
  end
end
