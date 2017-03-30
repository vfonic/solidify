module Spree
  class VariantDrop < ::Liquid::Rails::Drop
    attributes(*VariantFields::JSON)

    # For a variant to be available, its variant.inventory_quantity must be
    # greater than zero or variant.inventory_policy must be set to continue. A
    # variant with no variant.inventory_management is also considered available.
    def available
      # inventory_management.blank? ||
      # inventory_policy == INVENTORY_POLICY_ALLOW ||
      # inventory_quantity(??? check VariantDrop) > 0
      # call Variant.available, because ProductDrop calls Variant.available
      # both should always call the same method
      # (either in Variant or in VariantDrop)
      @object.available
    end

    def barcode
      ''
    end

    def compare_at_price
      nil
    end

    def featured_image
      @object.images.first
    end

    alias image featured_image

    def incoming
      false
    end

    def inventory_management
      'shopify'
    end

    def inventory_policy
      Solidify::InventoryPolicy::INVENTORY_POLICY_DENY
    end

    def inventory_quantity
      @object.total_on_hand
    end

    def name
      "#{@object.name} - #{title}"
    end

    def next_incoming_date
      nil
    end

    def option1
      @object.option_values.first.try(:presentation)
    end

    def option2
      @object.option_values.second.try(:presentation)
    end

    def option3
      @object.option_values.third.try(:presentation)
    end

    def options
      @object.option_values.map(&:presentation)
    end

    def price
      @object.price.to_money.cents
    end

    def requires_shipping
      true
    end

    def selected
      @object.product.selected_variant == @object
    end

    def taxable
      true
    end

    def title
      @object.option_values.map(&:presentation).join(' / ')
    end

    alias public_title title

    def url
      Solidify::Engine.routes.url_helpers
                      .variant_path(@object.product, @object)
    end

    def weight
      @object.weight.to_i
    end

    def weight_in_unit
      @object.weight.to_i
    end

    def weight_unit
      'kg'
    end
  end
end
