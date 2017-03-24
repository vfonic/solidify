require 'spree/testing_support/factories/address_factory'

FactoryGirl.modify do
  factory :address do
    state nil
    country nil
    zipcode '10110'
  end
end
