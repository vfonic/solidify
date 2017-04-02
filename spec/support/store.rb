def setup_basic_store
  create(:store)
  allow_any_instance_of(Solidify::LiquidController)
    .to receive(:spree_current_user).and_return(nil)
  theme = create(:theme)
  page.driver.browser.set_cookie("active_theme_id=#{theme.id}")
end
