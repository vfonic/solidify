module Spree
  User.class_eval do
    include ::SolidusLiquid::FullName
    include Spree::OrderState

    has_many :orders
  end
end
