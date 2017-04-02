RSpec.feature 'Cart management' do
  before(:each) { setup_basic_store }

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
