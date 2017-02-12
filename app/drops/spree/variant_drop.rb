module Spree
  class VariantDrop < ::Liquid::Rails::Drop
    attributes :price

    def featured_image
      @object.images.first
    end
  end
end
