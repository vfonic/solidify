module Solidify
  class SearchDrop < ::Liquid::Rails::Drop
    attributes :performed, :results_count, :terms

    has_many :results
  end
end
