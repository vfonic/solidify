module Spree
  Product.class_eval do
    include ::RailsSettings::Extend
    include ::Solidify::Handle

    def available
      variants.any?(&:available)
    end

    # display_image just shows first image
    # probably producing many queries on the db
    alias_method :featured_image, :display_image
  end
end
