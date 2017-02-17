module Spree
  class VariantDrop < ::Liquid::Rails::Drop
    attributes :id, :price

    def featured_image
      @object.images.first
    end

    def title
      @object.name
    end
  end
end
