module Spree
  class ProductDrop < ::Liquid::Rails::Drop
    attributes(*ProductFields::JSON)

    has_many :images

    def available
      !@object.deleted?
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
