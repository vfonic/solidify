module Spree
  Taxon.class_eval do
    include ::SolidusLiquid::Handle
  end
end
