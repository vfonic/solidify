module Spree
  class UserFields
    JSON = nil

    METHODS = %w(
      id accepts_marketing addresses addresses_count default_address email
      first_name has_account last_name last_order name orders orders_count tags
      total_spent
    ).freeze

    PARAMS = %w(
    ).freeze
  end
end
