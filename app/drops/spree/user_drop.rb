module Spree
  class UserDrop < ::Liquid::Rails::Drop
    attributes :first_name, :last_name, :password, :email
    has_many :orders

    def errors
      SolidusLiquid::ErrorsDrop.new(@object.errors)
    end

    def password_needed
      true
    end
  end
end
