module Spree
  # RSpec.describe Discount, type: :model do
  RSpec.describe PromotionCode do
    xdescribe '#title' do
      it 'returns the discount code' do
        discount = Discount.new(code: 'CODE')

        expect(discount.title).to eq('CODE')
      end
    end

    xdescribe '::DISCOUNT_TYPES' do
      it 'returns expected items' do
        expect(Discount::DISCOUNT_TYPES).to eq(
          %w(FixedAmountDiscount PercentageDiscount ShippingDiscount)
        )
      end
    end
  end
end
