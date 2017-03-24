module Spree
  class ProductDrop < ::Liquid::Rails::Drop
    attributes(*ProductFields::JSON)

    has_many :collections, :images, :variants
    has_one :selected_or_first_available_variant

    def available
      !@object.deleted? && @object.variants_including_master.any?(&:available)
    end

    def collections
      @object.taxons
    end

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

    alias content description

    def first_available_variant
      @object.variants.find(&:available)
    end

    def options
      @object.option_types.map(&:presentation)
    end

    def price
      (@object.price * 100).to_i
    end

    alias price_max price
    alias price_min price

    def price_varies
      false
    end

    def selected_or_first_available_variant
      @object.variants.first
    end

    def tags
      []
    end

    def type
      ''
    end

    def url
      @object.url
    end

    def vendor
      Solidify::Setting['name']
    end

    # def metafields
    #   ::RailsSettings::ScopedSettingsDrop.new(@object.settings)
    # end

    # shopify json returns datetime in shop's timezone
    alias published_at created_at
  end
end
