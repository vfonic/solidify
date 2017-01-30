module Liquor
  module StringFilters
    def handle(string)
      string.parameterize
    end

    def pluralize(input, singular, plural)
      input == 1 ? singular : plural
    end
  end
end
