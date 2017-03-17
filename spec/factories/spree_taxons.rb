require 'spree/testing_support/factories/taxon_factory'

FactoryGirl.modify do
  factory :taxon do
    taxonomy nil
  end
end
