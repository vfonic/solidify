module Spree
  class TaxonDrop < ::Liquid::Rails::Drop
    attributes(*TaxonFields::JSON)

    has_many :products

    def all_products_count
      @object.products.size
    end

    def all_tags
      []
    end

    def description
      @object.description
    end

    alias body_html description

    def image
      @object.image
    end

    def products_count
      @object.products.size
    end

    def published_at
      @object.created_at
    end

    def published_scope
      'global'
    end

    def sort_order
      'alpha-asc'
    end

    def template_suffix
      ''
    end

    def updated_at
      @object.updated_at
    end

    def url
      @object.url
    end
  end
end
