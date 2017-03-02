module Spree
  class AddressDrop < ::Liquid::Rails::Drop
    attributes :id, :address1, :address2, :city, :company, :country,
               :country_code, :country_name, :default, :first_name, :last_name,
               :name, :phone, :province, :province_code, :zip

    def latitude; end

    def longitude; end

    def street
      @object.street
    end
  end
end
