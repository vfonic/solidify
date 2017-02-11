module Spree
  module TaxonExtension
    extend ::ActiveSupport::Concern

    included do
      include ::SolidusLiquid::Handle

      def title
        name
      end

      def title=(new_title)
        name = new_title
      end
    end
  end
end
