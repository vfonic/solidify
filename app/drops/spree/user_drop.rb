module Spree
  class UserDrop < ::Liquid::Rails::Drop
    attributes :first_name, :last_name, :password, :email, :password_needed
    has_many :orders

    def errors
      SolidusLiquid::ErrorsDrop.new(@object.errors)
    end
  end
end
