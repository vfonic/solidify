require 'spree/testing_support/factories/line_item_factory'

FactoryGirl.modify do
  factory :line_item do
    price nil
    after(:build) do |line_item, _evaluator|
      line_item.valid?
    end
  end
end
