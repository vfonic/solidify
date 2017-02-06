require 'rails_helper'

module SolidusLiquid
  RSpec.describe AssetPostprocessor do
    context 'assets/style.scss.liquid' do
      it 'creates two asset records' do
        theme = create(:theme)
        allow_any_instance_of(Theme).to receive(:settings) {
          { 'base_font_size' => '16px' }
        }

        expect { create(:asset, :stylesheet_liquid, theme: theme) }
          .to change(Asset, :count).by(2)
      end

      it 'creates style.scss.liquid and style.scss.css assets' do
        theme = create(:theme)
        allow_any_instance_of(Theme).to receive(:settings) {
          { 'base_font_size' => '16px' }
        }
        create(:asset, :stylesheet_liquid, theme: theme)

        expect(Asset.find_by(key: 'assets/style.scss.liquid')).to be_persisted
        expect(Asset.find_by(key: 'assets/style.scss.css')).to be_persisted
      end

      it 'handles empty file correctly'

      it 'handles wrong liquid and scss correctly'

      context 'style.scss.css exists' do
        it 'does not create new Asset record for style.scss.css' do
          theme = create(:theme)
          allow_any_instance_of(Theme).to receive(:settings) {
            { 'base_font_size' => '16px' }
          }
          create(:asset, :stylesheet_css, theme: theme)

          expect { create(:asset, :stylesheet_liquid, theme: theme) }
            .to change(Asset, :count).by(1)
          expect(theme.assets.where(key: 'assets/style.scss.css').count).to eq(1)
        end
      end
    end

    context 'assets/style.scss.css' do
      it 'compiles the scss file' do
        theme = create(:theme)
        allow_any_instance_of(Theme).to receive(:settings)

        expect { create(:asset, :stylesheet_scss, theme: theme) }
          .to change(Asset, :count).by(2)
      end

      context 'style.scss.css exists' do
        it 'does not create new Asset record for style.scss.css' do
          theme = create(:theme)
          allow_any_instance_of(Theme).to receive(:settings)
          create(:asset, :stylesheet_css, theme: theme)

          expect { create(:asset, :stylesheet_scss, theme: theme) }
            .to change(Asset, :count).by(1)
          expect(theme.assets.where(key: 'assets/style.scss.css').count).to eq(1)
        end
      end
    end

    context 'assets/shop.js.liquid' do
      it 'creates shop.js asset' do
        theme = create(:theme)
        allow_any_instance_of(Theme).to receive(:settings)

        expect { create(:asset, :javascript, theme: theme) }
          .to change(Asset, :count).by(2)
        expect(theme.assets.where(key: 'assets/shop.js').first).to be_persisted
      end
    end

    context 'snippets/open-graph-tags.liquid' do
      it 'does nothing' do
        theme = create(:theme)
        allow_any_instance_of(Theme).to receive(:settings)

        expect { create(:asset, :snippet, theme: theme) }
          .to change(Asset, :count).by(1)
      end
    end
  end
end
