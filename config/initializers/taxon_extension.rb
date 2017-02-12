module Spree
  Taxon.class_eval do
    include ::SolidusLiquid::Handle

    def title
      name
    end

    def title=(new_title)
      name = new_title
    end
  end
end
