module Solidify
  class ShopSettingsSeeder
    def initialize(theme_id)
      @theme_id = theme_id
    end

    # rubocop:disable Metrics/MethodLength
    def seed
      {
        'active_theme_id' => @theme_id,
        'checkout' => { 'guest_login' => false },
        'currency' => 'USD',
        'customer_accounts_enabled' => true,
        'customer_accounts_optional' => true,
        'description' => '',
        'domain' => ENV.fetch('DOMAIN_NAME'),
        'enabled_payment_types' => nil,
        'money_format' => '€{{amount}}',
        'money_with_currency_format' => '€{{amount}} EUR',
        'name' => 'Split'
      }.each do |k, v|
        Solidify::Setting[k] = v
      end
    end
  end
end
