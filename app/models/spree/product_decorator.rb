module Spree
  Product.class_eval do
    include ::RailsSettings::Extend
    include ::SolidusLiquid::Handle

    def title
      name
    end

    def title=(new_title)
      name = new_title
    end
  end
end
