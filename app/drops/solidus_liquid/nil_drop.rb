module SolidusLiquid
  class NilDrop < ::Liquid::Rails::Drop
    def liquid_method_missing(method)
      nil
    end
  end
end
