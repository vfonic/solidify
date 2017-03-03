module Spree
  module OrderState
    extend ActiveSupport::Concern
    CART = 'cart'.freeze
    ADDRESS = 'address'.freeze
    DELIVERY = 'delivery'.freeze
    PAYMENT = 'payment'.freeze
    CONFIRM = 'confirm'.freeze
    COMPLETE = 'complete'.freeze
  end
end
