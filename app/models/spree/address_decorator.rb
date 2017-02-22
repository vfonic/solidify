module Spree
  Address.class_eval do
    include ::SolidusLiquid::Address
    include ::SolidusLiquid::FullName

    def default
      user_address.default
    end

    def province
      state.name
    end

    def province_code
      state.abbr
    end

    alias_attribute :zip, :zipcode
  end
end
