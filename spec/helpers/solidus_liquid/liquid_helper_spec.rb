require 'rails_helper'

module SolidusLiquid
  RSpec.describe LiquidHelper do
    describe '#content_for_header' do
      it 'renders content from file' do
        expect(helper.content_for_header)
          .to include('Shopify.shop = "shopify-split.myshopify.com";')
      end
    end

    describe '#theme' do
      xit 'returns currently active theme' do
        theme = create(:theme)
        cookies['active_theme_id'] = theme.id

        expect(helper.theme).to eq(theme)
      end

      xit 'does not query database on repeated calls' do
        theme = create(:theme)
        cookies['active_theme_id'] = theme.id
        allow(Theme).to receive(:find).and_call_original

        helper.theme
        helper.theme

        expect(Theme).to have_received(:find).once
      end
    end

    xdescribe '#theme_dir' do
      it 'returns theme dir for theme' do
        theme = create(:theme)
        cookies['active_theme_id'] = theme.id

        expect(helper.theme_dir).to eq("themes/#{theme.id}")
      end
    end

    describe '#controller_action_to_liquid_file_path' do
      it 'returns template path' do
        allow(helper).to receive(:theme_dir) { 'themes/2' }

        expect(
          helper.controller_action_to_liquid_file_path(nil, 'collections#show')
        ).to eq('themes/2/templates/collection.liquid')
      end

      context 'with template_suffix' do
        it 'returns template path' do
          record = double('page', template_suffix: 'contact')
          allow(helper).to receive(:theme_dir).and_return('themes/2')

          expect(
            helper.controller_action_to_liquid_file_path(record, 'pages#show')
          ).to eq('themes/2/templates/page.contact.liquid')
        end

        context 'when template file missing' do
          xit 'returns base template path' do
            theme = create(:theme)
            cookies['active_theme_id'] = theme.id
            record = double('page', template_suffix: 'contact')
            allow(helper).to receive(:controller_name) { 'pages' }
            allow(helper).to receive(:action_name) { 'show' }

            expect(helper.controller_action_to_liquid_file_path(record))
              .to eq("themes/#{theme.id}/templates/page.liquid")
          end
        end
      end
    end
  end
end
