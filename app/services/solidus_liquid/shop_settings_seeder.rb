module SolidusLiquid
  class ShopSettingsSeeder
    def initialize(theme_id)
      @theme_id = theme_id
    end

    def seed
      {
        'active_theme_id' => @theme_id,
        'name' => 'Split',
        # these two should be false to achieve parity with shopify
        'customer_accounts_enabled' => true,
        'customer_accounts_optional' => true,
        'enabled_payment_types' => nil
      }.each do |k, v|
        SolidusLiquid::Setting[k] = v
      end
    end
  end
end
