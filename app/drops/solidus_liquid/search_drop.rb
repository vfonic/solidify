module SolidusLiquid
  class SearchDrop < ::Liquid::Rails::Drop
    attributes :performed, :results, :results_count, :terms

    def to_s
      ''
    end
  end
end
