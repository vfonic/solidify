module Spree
  class LineItemDrop < ::Liquid::Rails::Drop
    attributes(*LineItemFields::JSON)

    def discounts
      []
    end

    alias key id

    def gift_card
      false
    end

    def grams
      @object.variant.weight
    end

    def handle
      @object.product.handle
    end

    def image
      @object.variant.display_image
    end

    def line_price
      price * quantity
    end

    alias original_line_price line_price

    def price
      Spree::VariantDrop.new(@object.variant).price
    end

    alias discounted_price price
    alias original_price price

    def product_description
      @object.product.description
    end

    def product
      @object.product
    end

    def product_id
      @object.product.id
    end

    alias product_title product_description

    def product_type
      Spree::ProductDrop.new(@object.product).type
    end

    def properties
      nil
    end

    def requires_shipping
      true
    end

    def title
      Spree::VariantDrop.new(@object.variant).name
    end

    def total_discount
      0
    end

    def url
      Spree::VariantDrop.new(@object.variant).url
    end

    def variant
      @object.variant
    end

    def variant_id
      @object.variant.id
    end

    def variant_options
      Spree::VariantDrop.new(@object.variant).options
    end

    def variant_title
      Spree::VariantDrop.new(@object.variant).title
    end

    def vendor
      Spree::ProductDrop.new(@object.product).vendor
    end
  end
end
