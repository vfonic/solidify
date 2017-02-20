module Spree
  Product.class_eval do
    include ::RailsSettings::Extend
    include ::SolidusLiquid::Handle
  end
end
