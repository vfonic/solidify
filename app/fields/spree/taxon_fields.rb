module Spree
  class TaxonFields
    JSON = %w(
      id body_html handle published_at published_scope sort_order
      template_suffix title updated_at
    ).freeze

    METHODS = %w(
      id all_tags all_types all_products_count all_vendors current_type
      current_vendor default_sort_by description handle image next_product
      previous_product products products_count published_at template_suffix
      title tags url
    ).freeze

    PARAMS = %w(
    ).freeze
  end
end
