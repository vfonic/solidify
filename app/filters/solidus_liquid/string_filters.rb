module SolidusLiquid
  module StringFilters
    def handle(string)
      string.try(:parameterize)
    end

    alias handleize handle

    def pluralize(input, singular, plural)
      input == 1 ? singular : plural
    end
  end
end
