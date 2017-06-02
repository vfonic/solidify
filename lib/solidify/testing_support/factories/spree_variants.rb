require 'spree/testing_support/factories/variant_factory'

FactoryGirl.modify do
  factory :variant do
    product
  end
end
