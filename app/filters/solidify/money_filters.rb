module Solidify
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

    def render_money(price_in_cents, template, options = {})
      price = price_in_cents.to_f / 100
      formatter = ActionController::Base.helpers.method(:number_with_precision)

      ::Liquid::Template.parse(template).render(
        'amount' => formatter.call(price, options.merge(precision: 2)),
        'amount_no_decimals' =>
          formatter.call(price, options.merge(precision: 0)),
        'amount_with_comma_separator' =>
          formatter.call(price, options.merge(precision: 2,
                                              delimiter: '.', separator: ','))
      )
    end
  end
end
