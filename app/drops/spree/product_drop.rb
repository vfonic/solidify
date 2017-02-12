module Spree
  class ProductDrop < ::Liquid::Rails::Drop
    attributes :id, :available, :description, :price

    has_many :images

    def content
      @object.description
    end

    alias compare_at_price price

    def featured_image
      @object.images.first
    end

    def price_varies
      false
    end

    def title
      @object.name
    end

    def url
      @object.slug
    end

    def vendor
      nil
    end
  end
end
