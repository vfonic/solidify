module Spree
  Taxon.class_eval do
    include ::Solidify::Handle

    class << self
      def find_or_create_collections_all
        collection = Spree::Taxon.find_by(handle: 'all')

        unless collection.present?
          collection = ::Solidify::CollectionsAllBuilder.create!
        end

        collection
      end
    end
  end
end
