require 'rails_helper'

module Solidify
  RSpec.describe ScssAssetCompiler do
    describe '#compile' do
      before(:all) do
        Asset.skip_callback(:save, :before, :postprocess_asset)
      end

      it 'compiles the scss asset' do
        asset = create(:asset, :stylesheet_scss)

        rendered_css = ScssAssetCompiler.new(File.read(asset.file.path)).compile

        expect(rendered_css)
          .to eq("body{width:960px}\n")
      end

      after(:all) do
        Asset.set_callback(:save, :before, :postprocess_asset)
      end
    end
  end
end
