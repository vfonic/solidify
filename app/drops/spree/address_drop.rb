module Spree
  class AddressDrop < ::Liquid::Rails::Drop
    attributes(*AddressFields::JSON)

    def latitude; end

    def longitude; end

    def street
      @object.street
    end
  end
end
