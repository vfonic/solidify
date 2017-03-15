module Solidify
  class NilDrop < ::Liquid::Rails::Drop
    def liquid_method_missing(_method)
      nil
    end
  end
end
