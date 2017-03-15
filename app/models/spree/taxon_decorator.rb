module Spree
  Taxon.class_eval do
    include ::Solidify::Handle
  end
end
