module Spree
  class AddressFields
    JSON = %w(
      id address1 address2 city company country country_code country_name
      default first_name last_name name phone province province_code zip
    ).freeze

    METHODS = %w(
      id address1 address2 city company country country_code default first_name
      last_name latitude longitude name phone province province_code street zip
    ).freeze

    PARAMS = %w(
      id address1 address2 city company country default first_name last_name
      phone province zip
    ).freeze
  end
end
