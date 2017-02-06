class Search
  include Liquid::Rails::Droppable

  attr_accessor :performed, :results, :results_count, :terms
end
