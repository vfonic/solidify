module Spree
  Product.class_eval do
    include ::RailsSettings::Extend
    include ::Solidify::Handle

    # display_image just shows first image
    # probably producing many queries on the db
    alias_method :featured_image, :display_image
  end
end
