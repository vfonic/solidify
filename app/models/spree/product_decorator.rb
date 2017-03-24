module Spree
  Product.class_eval do
    include ::RailsSettings::Extend
    include ::Solidify::Handle

    attr_accessor :selected_variant
  end
end
