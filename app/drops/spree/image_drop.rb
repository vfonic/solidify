module Spree
  class ImageDrop < ::Liquid::Rails::Drop
    attributes :id, :alt, :attached_to_variant?, :attachment, :position,
               :product_id, :src, :variants

    def variants
      if @object.viewable.present?
        [Spree::VariantDrop.new(@object.viewable)]
      else
        []
      end
    end

    def to_json(_json)
      @object.try(:attachment).try(:url).try(:to_json)
    end
  end
end
