module Spree
  class ProductDrop < ::Liquid::Rails::Drop
    attributes :description

    def content
      @object.description
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
