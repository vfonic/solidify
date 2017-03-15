module Solidify
  RSpec.describe MoneyFilters, type: :helper do
    describe '#money' do
      context '${{ amount }}' do
        it 'returns correct amount' do
          allow_any_instance_of(ShopHelper).to receive(:shop_settings)
            .and_return('money_format' => '${{ amount }}')

          expect(helper.money(145)).to eq('$1.45')
        end
      end

      context '€{{ amount_no_decimals }}' do
        it 'returns correct amount' do
          allow_any_instance_of(ShopHelper).to receive(:shop_settings)
            .and_return('money_format' => '€{{ amount_no_decimals }}')

          expect(helper.money(145)).to eq('€1')
        end
      end

      context '{{ amount_with_comma_separator }} kn' do
        it 'returns correct amount' do
          allow_any_instance_of(ShopHelper).to receive(:shop_settings) do
            { 'money_format' => '{{ amount_with_comma_separator }} kn' }
          end

          expect(helper.money(145)).to eq('1,45 kn')
        end
      end
    end

    describe '#money_with_currency' do
      it 'returns correct amount' do
        allow_any_instance_of(ShopHelper).to receive(:shop_settings)
          .and_return('money_with_currency_format' => '${{ amount }} CAD')

        expect(helper.money_with_currency(145)).to eq('$1.45 CAD')
      end
    end

    describe '#money_without_currency' do
      it 'renders the currency' do
        expect(helper.money_without_currency(145)).to eq(1.45)
      end
    end

    describe '#money_without_trailing_zeros' do
      it 'renders the currency' do
        allow_any_instance_of(ShopHelper).to receive(:shop_settings)
          .and_return('money_with_currency_format' => '${{ amount }} CAD')

        expect(helper.money_without_trailing_zeros(2000)).to eq('$20 CAD')
      end
    end
  end
end
