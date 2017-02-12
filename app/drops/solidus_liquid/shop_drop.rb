module SolidusLiquid
  class ShopDrop < ::Liquid::Rails::Drop
    def address
      ::Spree::Address.find(Setting.shop_address_id)
    end

    def name
      Setting.name
    end

    delegate :currency, :customer_accounts_enabled, :customer_accounts_optional, :enabled_payment_types, to: Setting
  end
end
