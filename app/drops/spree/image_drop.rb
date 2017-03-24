module Spree
  class ImageDrop < ::Liquid::Rails::Drop
    attributes :id, :alt, :attached_to_variant?, :attachment, :position,
               :product_id, :src, :variants

    has_many :variants

    def attached_to_variant?
      @object.viewable.present? && !@object.viewable.is_master?
    end

    def product_id
      @object.viewable.try(:product_id)
    end

    def src
      @object.try(:attachment).try(:url)
    end

    def variants
      if @object.viewable.present?
        [Spree::VariantDrop.new(@object.viewable)]
      else
        []
      end
    end

    def as_json
      @object.try(:attachment).try(:url).try(:as_json)
    end
  end
end
