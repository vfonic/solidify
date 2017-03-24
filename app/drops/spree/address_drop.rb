module Spree
  class AddressDrop < ::Liquid::Rails::Drop
    include ::Solidify::Address
    include ::Solidify::FullName

    attributes(*AddressFields::JSON)

    def default
      @object.user_addresses.first.try(:default)
    end

    def latitude; end

    def longitude; end

    def province
      @object.state_name
    end

    def province_code
      @object.state_code
    end

    def zip
      @object.zipcode
    end
  end
end
