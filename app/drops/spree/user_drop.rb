module Spree
  class UserDrop < ::Liquid::Rails::Drop
    attributes :first_name, :last_name, :password, :email, :default_address
    has_many :orders
    has_many :addresses

    def addresses_count
      @object.addresses.count
    end

    def errors
      SolidusLiquid::ErrorsDrop.new(@object.errors)
    end

    def password_needed
      true
    end
  end
end
