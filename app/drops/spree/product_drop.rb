module Spree
  class ProductDrop < ::Liquid::Rails::Drop
    attributes :id, :available, :content, :compare_at_price,
               :compare_at_price_max, :compare_at_price_min,
               :compare_at_price_varies, :created_at, :description,
               :featured_image, :handle, :images, :options, :price, :price_max,
               :price_min, :price_varies, :published_at, :tags, :title, :type,
               :variants, :vendor

    def available
      @object.available?
    end

    def collections
      @object.taxons
    end

    alias content description

    def url
      @object.url
    end

    def variants
      @object.variants.to_a.map do |v|
        Spree::VariantDrop.new(v)
      end
    end

    # warning
    def compare_at_price
      nil
    end

    def compare_at_price_max
      0
    end

    def compare_at_price_min
      0
    end

    def compare_at_price_varies
      false
    end

    def price
      (@object.price * 100).to_i
    end

    alias price_max price
    alias price_min price

    def price_varies
      false
    end

    def tags
      []
    end

    def type
      ''
    end

    def vendor
      Solidify::Setting['name']
    end

    # shopify json returns datetime in shop's timezone
    alias published_at created_at

    # error
    # TODO: check if shopify returns variant images as well
    # Spree::Product.images delegates to master variant
    def images
      @object.images.map(&:attachment).map(&:url)
    end

    def metafields
      ::RailsSettings::ScopedSettingsDrop.new(@object.settings)
    end

    def options
      @object.option_types.map(&:presentation)
    end

    def selected_or_first_available_variant
      @object.variants.first
    end
  end
end
