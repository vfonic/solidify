module Spree
  User.class_eval do
    # include Spree::OrderState

    # has_many :orders, -> { where.not(state: OrderState::CART) }
    # has_one :cart, -> { where(state: OrderState::CART) },
    #         class_name: 'Spree::Order'
  end
end
