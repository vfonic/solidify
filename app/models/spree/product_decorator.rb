module Spree
  Product.class_eval do
    include ::RailsSettings::Extend
    include ::SolidusLiquid::Handle

    def available
      variants.any?(&:available)
    end
  end
end
