module Spree
  class Taxon < ::Spree::Base
    include ::SolidusLiquid::Handle

    def title
      name
    end

    def title=(new_title)
      name = new_title
    end
  end
end
