RSpec.feature 'Homepage' do
  before(:each) { setup_basic_store }

  xscenario 'pages[settings.homepage_page].empty? returns true' do
    visit root_path

    expect(page).not_to have_selector('.rte')
  end
end
