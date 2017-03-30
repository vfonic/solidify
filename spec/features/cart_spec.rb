RSpec.feature 'Cart management' do
  before(:each) do
    create(:store)
    allow_any_instance_of(Solidify::LiquidController)
      .to receive(:spree_current_user).and_return(nil)
    theme = create(:theme)
    page.driver.browser.set_cookie("active_theme_id=#{theme.id}")
  end

  scenario 'User sees empty cart' do
    visit root_path

    within('.cart-link') do
      expect(page).to have_text('0 items')
    end
  end

  xscenario 'New order is not created' do
    visit root_path

    expect(Spree::Order.count).to be_zero
  end
end
