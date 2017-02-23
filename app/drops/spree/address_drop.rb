module Spree
  class AddressDrop < ::Liquid::Rails::Drop
    attributes :id, :address1, :address2, :city, :company, :country,
               :country_code, :default, :first_name, :last_name, :latitude,
               :longitude, :name, :phone, :province, :province_code, :street,
               :zip

    def country
      @object.country.name
    end

    def country_code
      @object.country.iso
    end

    def latitude
      0
    end

    def longitude
      0
    end
  end
end
