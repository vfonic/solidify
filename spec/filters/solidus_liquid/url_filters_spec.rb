require 'rails_helper'

module SolidusLiquid
  RSpec.describe UrlFilters, type: :helper do
    describe '#asset_url' do

      it 'returns correct asset_url for theme' do
        theme = create(:theme)
        context = double('@context', registers: { theme: theme })
        helper.instance_variable_set(:@context, context)

        expect(helper.asset_url('shop.js'))
          .to eq('https://bucket-name.s3.amazonaws.com/' \
            "themes/#{theme.id}/assets/shop.js")
      end
    end

    describe '#customer_login_link' do
      it 'returns customer_login_link with correct text' do
        expect(helper.customer_login_link('Log me in'))
          .to eq(%(<a href="/account/login">Log me in</a>))
      end
    end

    describe '#customer_register_link' do
      it 'returns customer_register_link with correct text' do
        expect(helper.customer_register_link('Register me'))
          .to eq(%(<a href="/account/register">Register me</a>))
      end
    end

    describe '#global_asset_url' do
      it 'fetches global_asset_url from url mapping' do
        expect(helper.global_asset_url('shopify_common.js'))
          .to eq('https://shopify-split.s3.amazonaws.com/global/shopify_common.js')
      end
    end

    describe '#shopify_asset_url' do
      xit 'calls global_asset_url' do
        allow(helper).to receive(:global_asset_url)

        helper.shopify_asset_url('shopify_common.js')

        expect(helper)
          .to have_received(:global_asset_url)
      end
    end
  end
end
