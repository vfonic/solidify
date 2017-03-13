module SolidusLiquid
  module MoneyFilters
    include ShopHelper

    def money(price_in_cents)
      render_money(price_in_cents, shop_settings['money_format'])
    end

    def money_with_currency(price_in_cents)
      render_money(price_in_cents, shop_settings['money_with_currency_format'])
    end

    def money_without_currency(price_in_cents)
      price_in_cents.to_f / 100
    end

    def money_without_trailing_zeros(price_in_cents)
      render_money(price_in_cents,
                   shop_settings['money_with_currency_format'],
                   strip_insignificant_zeros: true)
    end

    private

    def render_money(price_in_cents, format, options = {})
      price = price_in_cents.to_f / 100
      template = Liquid::Template.parse(format)
      template.render(
        'amount' =>
        number_with_precision(price, options.reverse_merge(precision: 2)),
        'amount_no_decimals' =>
        number_with_precision(price, options.reverse_merge(precision: 0)),
        'amount_with_comma_separator' =>
        number_with_precision(price, options.reverse_merge(precision: 2))
        .tr('.', ',')
      )
    end
  end
end
