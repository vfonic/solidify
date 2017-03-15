module Spree
  User.class_eval do
    include ::Solidify::FullName
    include Spree::OrderState

    has_many :orders
  end
end
