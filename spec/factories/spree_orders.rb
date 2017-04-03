require 'spree/testing_support/factories/order_factory'

FactoryGirl.modify do
  factory :order_with_line_items do
    transient do
      shipment_cost 0
    end
  end
end
