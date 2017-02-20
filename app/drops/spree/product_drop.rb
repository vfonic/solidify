module Spree
  class ProductDrop < ::Liquid::Rails::Drop
    attributes :id, :available, :description, :handle, :price, :title, :url

    has_many :images

    def collections
      @object.taxons
    end

    def content
      @object.description
    end

    alias compare_at_price price

    def featured_image
      @object.images.first || ::SolidusLiquid::NilDrop.new(nil)
    end

    def metafields
      ::RailsSettings::ScopedSettingsDrop.new(@object.settings)
    end

    def options
      @object.option_types
    end

    def price_varies
      false
    end

    def selected_or_first_available_variant
      @object.master
    end

    def variants
      @object.variants_including_master
    end

    def vendor
      nil
    end
  end
end
