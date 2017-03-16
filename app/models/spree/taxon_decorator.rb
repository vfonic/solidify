module Spree
  Taxon.class_eval do
    include ::Solidify::Handle

    class << self
      def find_or_create_collections_all
        collection = Spree::Taxon.find_or_initialize_by(handle: 'all')

        unless collection.persisted?
          collection.permalink = 'all'
          collection.title = 'Products'
          collection.save
        end

        collection.products = Spree::Product.all if collection.products.empty?

        collection
      end
    end
  end
end
