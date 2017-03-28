module Spree
  module OrderState
    extend ActiveSupport::Concern
    # https://github.com/solidusio/solidus/blob/master/core/app/models/spree/order/checkout.rb
    # checkout flow
    CART = 'cart'.freeze
    ADDRESS = 'address'.freeze
    DELIVERY = 'delivery'.freeze
    PAYMENT = 'payment'.freeze
    CONFIRM = 'confirm'.freeze
    COMPLETE = 'complete'.freeze

    # other states
    AWAITING_RETURN = 'awaiting_return'.freeze
    CANCELED = 'canceled'.freeze
    RESUMED = 'resumed'.freeze
    RETURNED = 'returned'.freeze
  end
end
