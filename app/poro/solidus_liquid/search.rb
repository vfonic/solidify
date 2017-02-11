module SolidusLiquid
  class Search < Struct.new(:performed, :results, :results_count, :terms)
    include ::Liquid::Rails::Droppable
  end
end
