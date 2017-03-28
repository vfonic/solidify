module Spree
  Taxon.class_eval do
    include ::Solidify::Handle

    has_one :image,
            as: :viewable, dependent: :destroy, class_name: 'Spree::Image'

    class << self
      def find_or_create_collections_all
        collection = Spree::Taxon.find_by(handle: 'all')

        if collection.blank?
          collection = ::Solidify::CollectionsAllBuilder.create!
        end

        collection
      end
    end
  end
end
