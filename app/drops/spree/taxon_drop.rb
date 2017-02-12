module Spree
  class TaxonDrop < ::Liquid::Rails::Drop
    attributes :handle, :title

    has_many :products

    def all_tags
      { 'size' => 0 }
    end

    def default_sort_by
      ''
    end

    def description
      if @object.description.nil?
        ''
      else
        @object.description
      end
    end

    def products_count
      @object.products.count
    end

    def sort_by
      ''
    end
  end
end
