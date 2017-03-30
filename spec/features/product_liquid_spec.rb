RSpec.feature 'Product viewing' do
  before(:each) do
    create(:store)
    allow_any_instance_of(Solidify::LiquidController)
      .to receive(:spree_current_user).and_return(nil)
    theme = create(:theme)
    page.driver.browser.set_cookie("active_theme_id=#{theme.id}")

    allow_any_instance_of(Solidify::ShopHelper).to receive(:shop_settings)
      .and_return('money_format' => '€{{ amount }}')
  end

  let(:master) { build(:variant, is_master: true, price: 69.96) }
  let(:product) { create(:product, master: master) }

  context 'product with no variants' do
    scenario 'User sees master variant price' do
      visit product_path(product)

      expect(page).to have_selector('.product-price', text: '€69.96')
    end
  end

  xcontext 'product with variants' do
    before(:each) do
      product.variants << build(:variant, price: 9.99)
    end

    scenario 'User sees first variant price' do
      visit product_path(product)

      expect(page).to have_selector('.product-price', text: '€9.99')
    end
  end
end
