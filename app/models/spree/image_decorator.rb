module Spree
  Image.class_eval do
    def attached_to_variant?
      viewable.present? && !viewable.is_master?
    end

    def product_id
      viewable.try(:product_id)
    end

    def src
      attachment.try(:url)
    end

    def as_json(options={})
      src
    end
  end
end
