module Solidify
  class Search
    include ::Liquid::Rails::Droppable

    attr_accessor :performed, :results, :results_count, :terms

    def initialize(performed: nil, results: nil, results_count: nil, terms: nil)
      @performed = performed
      @results = results
      @results_count = results_count
      @terms = terms
    end
  end
end
