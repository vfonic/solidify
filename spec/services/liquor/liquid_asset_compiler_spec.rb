module Liquor
  RSpec.describe LiquidAssetCompiler do
    describe '#compile' do
      before(:all) do
        Asset.skip_callback(:save, :before, :postprocess_asset)
      end

      it 'compiles the liquid asset with theme settings' do
        theme = create(:theme)
        asset = create(:asset, :stylesheet_liquid, theme: theme)

        rendered_liquid = LiquidAssetCompiler.new(
          File.read(asset.file.path),
          { 'base_font_size' => '16px' },
          theme
        ).compile

        expect(rendered_liquid)
          .to eq("$width: 60 * 16px;\n\nbody {\n  width: $width;\n}\n")
      end

      it 'compiles the liquid asset with asset_url' do
        theme = create(:theme)
        asset = create(:asset, :stylesheet_liquid_with_asset_url, theme: theme)

        rendered_liquid = LiquidAssetCompiler.new(
          File.read(asset.file.path),
          { 'base_font_size' => '16px' },
          theme
        ).compile

        asset_url = 'https://bucket-name.s3.amazonaws.com' \
                    "/themes/#{theme.id}/assets/arrow-down.svg"
        expected = <<~HEREDOC
                body {
                  background: url(#{asset_url}) right 0.4em center no-repeat;
                }
                HEREDOC

        expect(rendered_liquid)
          .to eq(expected)
      end

      after(:all) do
        Asset.set_callback(:save, :before, :postprocess_asset)
      end
    end
  end
end
