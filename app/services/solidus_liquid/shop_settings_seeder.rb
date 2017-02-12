module SolidusLiquid
  class ShopSettingsSeeder
    def initialize(theme_id)
      @theme_id = theme_id
    end

    def seed
      {
        'active_theme_id' => @theme_id,
        # these two should be false to achieve parity with shopify
        'checkout' => { 'guest_login' => false },
        'currency' => 'USD',
        'customer_accounts_enabled' => true,
        'customer_accounts_optional' => true,
        'enabled_payment_types' => nil,
        'name' => 'Split',
        'url' => ENV.fetch('DOMAIN_NAME')
      }.each do |k, v|
        SolidusLiquid::Setting[k] = v
      end
    end
  end
end
