module Spree
  Variant.class_eval do
    def available
      true
    end

    def as_json(_options = {})
      Spree::VariantDrop.new(self).as_json
    end
  end
end
