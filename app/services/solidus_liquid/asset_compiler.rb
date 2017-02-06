module SolidusLiquid
  module AssetCompiler
    def initialize(template)
      @template = template
    end

    def compile
      raise 'Implement in subclass'
    end
  end
end
