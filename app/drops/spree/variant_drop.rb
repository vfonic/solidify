module Spree
  class VariantDrop < ::Liquid::Rails::Drop
    include SolidusLiquid::InventoryPolicy

    attributes :id, :available, :barcode, :compare_at_price, :featured_image,
               :inventory_management, :inventory_policy, :inventory_quantity,
               :name, :option1, :option2, :option3, :options, :price,
               :public_title, :requires_shipping, :sku, :taxable, :title,
               :weight

    # warning
    def barcode
      ''
    end

    def compare_at_price
      nil
    end

    def inventory_management
      'shopify'
    end

    def inventory_policy
      SolidusLiquid::InventoryPolicy::INVENTORY_POLICY_DENY
    end

    def inventory_quantity
      @object.total_on_hand
    end

    def name
      "#{@object.name} - #{title}"
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
      (@object.price * 100).to_i
    end

    def requires_shipping
      true
    end

    def taxable
      true
    end

    def title
      # @object.name
      @object.option_values.map(&:presentation).join(' / ')
    end

    alias public_title title

    def weight
      @object.weight.to_i
    end

    # error
    def featured_image
      @object.images.first.try(:attachment).try(:url)
    end
  end
end
