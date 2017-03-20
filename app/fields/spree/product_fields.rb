module Spree
  class ProductFields
    JSON = %w(
      id available compare_at_price compare_at_price_max compare_at_price_min
      compare_at_price_varies content created_at description featured_image
      handle images options price price_max price_min price_varies published_at
      tags title type variants vendor
    ).freeze

    METHODS = %w(
      id available collections compare_at_price_max compare_at_price_min
      compare_at_price_varies content description featured_image
      first_available_variant handle images options options_with_values price
      price_max price_min price_varies selected_variant
      selected_or_first_available_variant tags template_suffix title type url
      variants vendor
    ).freeze

    PARAMS = %w(
    ).freeze
  end
end
