module RailsSettings
  class ScopedSettingsDrop < ::Liquid::Rails::Drop
    def liquid_method_missing(method)
      if method.present?
        ::Solidify::NilDrop.new(nil)
      else
        super
      end
    end
  end
end
