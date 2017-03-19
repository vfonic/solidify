module Solidify
  class CollectionsAllBuilder
    def self.create!
      ::Spree::Taxon.create!(
        handle: 'all',
        permalink: 'all',
        title: 'Products',
        products: Spree::Product.all
      )
    end
  end
end
