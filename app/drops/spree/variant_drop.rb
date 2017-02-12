module Spree
  class VariantDrop < ::Liquid::Rails::Drop
    # attributes :id, :available, :description, :price

    def featured_image
      @object.images.first
    end
  end
end
