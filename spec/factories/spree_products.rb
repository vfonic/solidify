require 'spree/testing_support/factories/product_factory'

FactoryGirl.modify do
  factory :product do
    shipping_category_id 1
  end
end
